# account user
# permissions copied to the account with lists for easy access
# Roles: Catalog User is auto generated when an invitation to a catalog is send

class AccountUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :customer_events
  has_many :catalog_users, dependent: :destroy
  

  validates_uniqueness_of :user_id, :scope => :account_id
  

  ROLES            = [  "Account Owner", 
                        "Administrator", 
                        "Client", 
                        "Super",
                        "Catalog User",
                        "Account User"
                      ]
                      
  
  # setup of search
  include PgSearch
  pg_search_scope :search_account_user, against: [:name, :email, :note, :phone], :using => [:tsearch]
  
  # 
  after_commit    :update_cache
  
  before_save     :update_uuids
  
  # force the cache to rebuild
  before_destroy  :update_uuids
  #after_create    :update_catalog_users
  #after_update    :update_catalog_users

  
  scope :supers,            ->  { where.not( role: 'Super')  }
  scope :clients,           ->  { where( role: 'Client') }
  scope :administrators,    ->  { where( role: 'Administrator') }
  scope :owner,             ->  { where( role: 'Account Owner')  }
  # users invited
  scope :invited,           ->  { where.not( role: ['Catalog User', 'Super', 'Client', 'Account Owner', 'Administrator'])  }
  #scope :invited,   -> { joins(:dog).order('dogs.name') }

 
  
  # refrech memcach and force the segment cache to rerender
  def update_cache
    flush_cache
    # update uuid on the account
    self.account.save!
  end
  
  #!!! When is this used
  def copy_permissions_to_catalog_users
    if catalogs = self.account.catalogs
      
      catalogs.each do |catalog|
        catalog_user = CatalogUser.where(account_id: self.account_id, 
                                         user_id: self.user_id,
                                         catalog_id: catalog.id)
                                  .first_or_create(
                                         account_id: self.account_id, 
                                         catalog_id: catalog.id,
                                         user_id: self.user_id,
                                         role: 'Catalog User',
                                         email: self.user.email)
                                         
                                         
        #CopyPermissions.from_account_user_to_catalog_user( self, catalog_user )
        Permissions::TYPES.each do |permission_type|
          eval "catalog_user.#{permission_type}   = self.#{permission_type}" 
        end
        catalog_user.save!
      end
    end
  end
  
  def super?
    self.role == 'Super'
  end
  
  # set basic permissions to true
  def grand_basic_permissions
    
    self.create_recording     = true
    self.read_recording       = true
    self.update_recording     = true
    self.delete_recording     = true
    
    self.create_common_work   = true
      self.read_common_work   = true
    self.update_common_work   = true
    self.delete_common_work   = true
    
    self.read_catalog         = true
    self.update_catalog       = true
    
    save!
    
  end
  
  # set all permissions to true
  def grand_all_permissions
    #  copy permissions 
    Permissions::TYPES.each do |permission_type|
      eval "self.#{permission_type} = true" 
    end
    self.save!
    
    # add to all catalogs
    self.account.catalogs.each do |catalog|
      catalog.add_account_user self
    end

  end
  
  # set all permissions to false
  def remove_all_permissions
    Permissions::TYPES.each do |permission_type|
      eval "self.#{permission_type} = false" 
    end
    # save and update uuid
    self.save!
    
    # remove from all catalogs
    #self.account.catalogs.each do |catalog|
    #  catalog.remove_account_user self
    #end
    
    
  end
  

  # if the user has no permissions to an accout 
  # remove the user from the list of permitted_user_ids
  def check_permissions
    puts '++++++++++++++++++++++++++++++++++++++++++++++'
    puts ' Obsolete AccountUser#check_permissions'
    ## pessimistic
    #permission = false;
    ##  permissions 
    #Permissions::TYPES.each do |permission_type|
    #  if (eval "self.#{permission_type}") 
    #    permission = true
    #  end
    #end
    #if permission
    #  # add permission
    #  self.account.permitted_user_ids += [self.user_id]
    #else
    #  # remove permission
    #  self.account.permitted_user_ids -= [self.user_id]
    #end
    ## only store on id on white list
    #self.account.permitted_user_ids.uniq!
    #self.account.save!
  end
  
  def add_to_permitted_user_ids
    puts '++++++++++++++++++++++++++++++++++++++++++++++'
    puts ' Obsolete AccountUser#add_to_permitted_user_ids'
    #self.account.permitted_user_ids   += [self.user_id]
    #self.account.permitted_user_ids.uniq!
    #self.save!
    #update_catalog_users
  end

  
  
  def mount_user
    if user_id == -1
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      
      new_user = User.where(account_id: account_id, email: email)
                     .first_or_create(account_id: account_id, 
                                       name: get_name, 
                                       email: email, 
                                       role: 'cuctomer',
                                       password: secret_temp_password,
                                       password_confirmation: secret_temp_password, 
                                       activated: false)
      self.user_id = new_user.id
      self.save!

      
    end
  end

  def get_email
    return user.email
  end
  
  def get_name
    return name       unless name.to_s == ''
    if user
      return user.name  unless user.name.to_s == ''
      return user.email
    end
    return email
  end
  
  #def get_phone
  #  phone
  #end
  
  #def can_access_work common_work
  #  common_work.recordings.each do |recording|
  #    return true if recording.read_common_work_ids.include?  self.user_id
  #  end
  #  return false
  #  
  #end

  def can_manage_assets?   
    #return true if self.read_recording? 
    #return true if self.read_common_work?           
    return true if self.read_file?                
    return true if self.read_legal_document?        
    return true if self.read_financial_document?    
    return true if self.user.super?
    return false
  end
  
  def add_music?
    return true if self.create_common_work?
    return true if self.create_recording?
    return false
  end
  

  def self.account_search(account, query)
    account_users = account.account_users
    if query.present?
      return account_users.search_account_user(query)
    else
      return account_users
    end
  end
  

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_where(account_id, user_id)
    Rails.cache.fetch([ 'account_user', account_id, user_id]) { where( account_id: account_id, user_id: user_id ).first }
  end
  
  def can_add_content?
    return true if self.create_common_work
    return true if self.create_recording
    return false
  end
  
  # secure there is a catalog user for all catalogs on the account
  # only use this for account users
  def mount_to_catalogs
   
    self.account.catalogs.each do |catalog|
      mount_to_catalog catalog                        
    end
  end
  
  # ordanary users when invited
  def mount_to_catalog catalog
    
    catalog_user = CatalogUser.where(user_id:    self.user_id, 
                                           catalog_id: catalog.id
                                           )
                                    .first_or_create(  user_id:     self.user_id, 
                                                       account_user_id:  self.id,
                                                       catalog_id: catalog.id
                                                     )
                                                     
  end
  
  def update_catalog_users

    # make sure there is access to all catalogs
    mount_to_catalogs
    
    # set the permissions from the account user on the catalog users
    self.catalog_users.each do |catalog_user|
      # copy permissions from the account user
      catalog_user.copy_permissions_from_account_user self
      
    end
    update_cache
  end
  
  
 

private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['account_user', account_id, user_id])
  end
  
  #def remove_catalog_users
  #  self.catalog_users.each do |catalog_user|
  #    # only remove catalog users automatic generated for the account user
  #    if catalog_user.role == 'Account User'
  #      # but never remove super users
  #      catalog_user.destroy! unless catalog_user.user.super?
  #    end
  #  end
  #  
  #  update_uuids
  #end
  
  def update_uuids
    # !!! what is account cache
    AccountCache.update_users_uuid self.account
    # force segment cache for account user to rerender
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
    # force update of the users cache
    self.user.save!
  end
  
end
