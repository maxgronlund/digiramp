# account user
# permissions copied to the account with lists for easy access
# Roles: Catalog User is auto generated when an invitation to a catalog is send

class AccountUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :customer_events
  has_many :catalog_users
  

  validates_uniqueness_of :user_id, :scope => :account_id
  

  ROLES            = [  "Account Owner", 
                        "Administrator", 
                        "Client", 
                        "Super",
                        "Catalog User"
                      ]
                      
  
  
  include PgSearch
  pg_search_scope :search_account_user, against: [:name, :email, :note, :phone], :using => [:tsearch]
  
  
  after_commit    :update_cache
  
  before_save     :update_uuids
  #before_destroy  :update_uuids
  after_create    :add_to_permitted_user_ids
  after_update    :update_catalog_users

  
  scope :supers,            ->  { where.not( role: 'Super')  }
  scope :clients,           ->  { where( role: 'Client') }
  scope :administrators,    ->  { where( role: 'Administrator') }
  # users invited
  scope :invited,           ->  { where.not( role: ['Catalog User', 'Super', 'Client', 'Account Owner'])  }
  #scope :invited,   -> { joins(:dog).order('dogs.name') }

  def update_cache
    flush_cache
    # update uuid on the account
    account.save!
  end
  
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
  
  def grand_all_permissions
    #  permissions 
    Permissions::TYPES.each do |permission_type|
      eval "self.#{permission_type} = true" 
    end
    self.save!
    self.account.permitted_user_ids += [self.user_id]
    self.account.permitted_user_ids.uniq!
    self.account.save!
    
    self.account.catalogs.each do |catalog|
      catalog.add_account_user self
    end

  end
  
  def remove_all_permissions
    self.account.permitted_user_ids -= [self.user_id]
    self.account.save!
    #  remove permissions 
    Permissions::TYPES.each do |permission_type|
      eval "self.#{permission_type} = true" 
    end
    # save and update uuid
    self.save!
  end
  

  
  def check_permissions
    # pessimistic
    permission = false;
    #  permissions 
    Permissions::TYPES.each do |permission_type|
      if (eval "self.#{permission_type}") 
        permission = true
      end
    end
    if permission
      # add permission
      self.account.permitted_user_ids += [self.user_id]
    else
      # remove permission
      self.account.permitted_user_ids -= [self.user_id]
    end
    # only store on id on white list
    self.account.permitted_user_ids.uniq!
    self.account.save!
  end
  
  def add_to_permitted_user_ids
    self.account.permitted_user_ids  += [self.user_id]
    self.account.permitted_user_ids.uniq!
    self.save!
    update_catalog_users
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
  
  def get_phone
    phone
  end
  
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
  
  def update_catalog_users
    self.catalog_users.each do |catalog_user|
      # copy permissions from the account user
      catalog_user.copy_permissions_from_account_user self
    end
    update_cache
  end
 
  #def update_catalog_user
  #
  #  catalog_user = CatalogUser.where(account_id:  self.account_id, 
  #                                   user_id:     self.user_id)
  #                            .first_or_create(
  #                                   account_id: self.account_id, 
  #                                   user_id:     self.user_id,
  #                                   role: 'Generated for an Account User')
  #                                   
  # 
  #  catalog_user.copy_permissions_from_account_user self
  #
  #  
  #end
  



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
    AccountCache.update_users_uuid self.account
    self.uuid = UUIDTools::UUID.timestamp_create().to_s

  end
  
end
