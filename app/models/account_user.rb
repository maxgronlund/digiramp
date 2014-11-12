# account user
# permissions copied to the account with lists for easy access
# Roles: Catalog User is auto generated when an invitation to a catalog is send

class AccountUser < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :account
  belongs_to :user
  belongs_to :administrator
  has_many :customer_events
  has_many :catalog_users, dependent: :destroy
  

  validates_uniqueness_of :user_id, :scope => :account_id
  

  ROLES            = [  "Account Owner", 
                        "Administrator", 
                        "Client User", 
                        "Super User",
                        "Catalog User",
                        "Account User"
                      ]
                      
  
  # setup of search
  include PgSearch
  pg_search_scope :search_account_user, against: [:name, :email, :note, :phone], :using => [:tsearch]
  
  # 
  after_commit    :update_cache
  
  before_save     :update_propperties
  before_destroy  :update_propperties
  #after_create    :update_catalog_users
  #after_update    :update_catalog_users

  
  scope :supers,            ->  { where( role: 'Super User')  }
  scope :clients,           ->  { where( role: 'Client User') }
  scope :administrators,    ->  { where( role: 'Administrator') }
  scope :owners,            ->  { where( role: 'Account Owner')  }
  # users invited
  scope :invited,           ->  { where.not( role: ['Catalog User', 'Super', 'Client', 'Account Owner', 'Administrator'])  }
  scope :non_catalog_users, ->  { where.not( role: 'Catalog User' )  }
  

  def uuid
    self.user.uuid
  end
  
  def update_to_super
    unless self.role == 'Account Owner'
      self.role     = 'Super User' 
      grand_all_permissions
    end
  end
  
  def downgrade
    unless self.role == 'Account Owner'
      self.destroy!
    end
  end

  
  # refrech memcach and force the segment cache to rerender
  def update_cache
    flush_cache
    # update uuid on the account
    # self.account.save!
  end
  
  def own_account? account
    self.user.account_id == account.user.account_id
  end
  
  def super?
    self.user.role == 'Super'
  end
  
  def administrates_account?
    account.administrator_id == self.user_id
  end
  
  # can update account_user
  def can_update_account_user account_user
    # only if there is permissions to update
    if self.user.super?
      return true unless account_user.user.super?
    end
    return false unless self.update_user
    handle_user_permissions_for account_user
  end
  
  # can delete account_user
  def can_delete_account_user account_user
    # only if there is permissions to update
    return false unless self.delete_user
    return false if account_user.role == 'Administrator'
    return false if account_user.role == 'Account Owner'
    handle_user_permissions_for account_user
  end
  
  # permissions based on role
  def handle_user_permissions_for account_user
    #puts '+++++++++++++++++++++++ handle_user_permissions_for ++++++++++++++++++++++++++'
    #puts account_user.user.email
    # always edit account users
    return true if account_user.role        == 'Account User'
                                            
    # never edit a super user               
    return false if account_user.role       == 'Super'
    
  
    # only administrators and supers can edit the account owner
    if account_user.role  == 'Account Owner'
      
      if account_user.account.administrator_id != account_user.account.user_id
        # the account is administrated
        return true if self.role == 'Super'
        return true if self.role == 'Administrator'
      end
      return false    
    end
    
    # never edit the administrator
    return false if account_user.role       == 'Administrator'
    
    # never grand catalog users 
    # access to the account
    return true if account_user.role        == 'Catalog User'
    
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
    puts 'ERROR: Unable assign edit permmision for account user'
    puts 'In AccountUser#has_permisions'
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++' 
    false
    
  end
  
  # set basic permissions to true
  def grand_basic_permissions
    remove_permissions
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
    
    self.save!
    
  end
  
  # set all permissions to false
  def remove_permissions
    Permissions::TYPES.each do |permission_type|
      #eval "self.#{permission_type} = false" 
      self[permission_type] = false
    end
    
    self.create_client = false
    self.read_client   = false
    self.update_client = false
    self.delete_client = false

  end
  
  # set all permissions to true
  def grand_all_permissions 
    #  copy permissions 
    Permissions::TYPES.each do |permission_type|
      #eval "self.#{permission_type} = true" 
      self[permission_type] = true
    end
    
    self.create_client = true
    self.read_client   = true
    self.update_client = true
    self.delete_client = true
    self.save!
    
    # add to all catalogs
    self.account.catalogs.each do |catalog|
      catalog_user = catalog.add_account_user self
    end

  end
  
  

  
  # strange to have this here?
  def mount_user
    if user_id == -1
      secret_temp_password = UUIDTools::UUID.timestamp_create().to_s
      
      new_user = User.where(account_id: account_id, email: email)
                     .first_or_create(account_id: account_id, 
                                       name: get_name, 
                                       email: email, 
                                       role: 'Customer',
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
    return true if self.user.super?          
    return true if self.read_file?                
    return true if self.read_legal_document?        
    return true if self.read_financial_document?    
    
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
    Rails.cache.fetch([ name, account_id, user_id]) { where( account_id: account_id, user_id: user_id ).first }
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
    #update_cache
  end
  
  def has_access_to_opertunities
    return true if self.read_opportunity
    return true if self.role == 'Super'
    return false
  end
 
  

private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, self.account_id, self.user_id])
  end
  
  def update_propperties
    update_uuids
  end
  
  def update_uuids
    # !!! what is account cache
    AccountCache.update_users_uuid self.account
    # force segment cache for account user to rerender
    #self.uuid = UUIDTools::UUID.timestamp_create().to_s
    # force update of the users cache
    #self.user.save!
  end
  
end
