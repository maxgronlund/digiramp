# a catalog user is a set of permissions for an persona
# the catalog user is always linked to a account user
#
class CatalogUser < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :user
  belongs_to :account
  belongs_to :catalog
  belongs_to :account_user
  
  after_commit  :flush_cache
  #before_save   :update_uuids
  #after_create  :attach_to_account_user
  #after_destroy :update_catalog_counter_cache
  

  scope :invited,           ->  { where( role: 'Catalog User').order("email asc")  }
  scope :account_users,     ->  { where( role: 'Account User').order("email asc")  }
  scope :account_owners,    ->  { where( role: 'Account Owner').order("email asc")  }
  
  # catalog users comes in four flavors
  # 1: Catalog User, this role is set when the catalog user is invited to a catalog
  # 2: Account User, this role is set when a user is invited to an account

  ROLE = ['Catalog User', 'Account User', 'Account Owner']
  
  
  def downgrade
    
  end

 
  #def update_catalog_counter_cache
  #  #CatalogUserCounterCachWorker.perform_async(self.catalog_id)
  #end
  
  
  #def update_uuids
  #  #self.uuid = UUIDTools::UUID.timestamp_create().to_s
  #end
  #
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_where(catalog_id, user_id)
    Rails.cache.fetch([ 'catalog_user', catalog_id, user_id]) { where( catalog_id: catalog_id, 
                                                                    user_id: user_id ).first 
                                                               }
  end
  
  
  # when a catalog user is created, the account user attached to an account_user
  # so the persona can access the hosting account true the account user
  def attach_to_account_user
    # find or create an account user for all catalog users
    account_user = AccountUser.where( account_id: self.account_id, 
                                      user_id:    self.user_id)
                              .first_or_create( account_id:   self.account_id, 
                                                user_id:      self.user_id,
                                                role:         'Catalog User',
                                                email:        self.user.email)

    account_user.save!                                       
    self.account_user_id      = account_user.id
    self.save!
  end
  
  
  # can update catalog_user
  def can_update_catalog_user catalog_user
    #puts '+++++++++++++++++++++++ can_update_catalog_user ++++++++++++++++++++++++++'
    # only if there is permissions to update
    return false unless self.update_user
    
    handle_user_permissions_for catalog_user
  end
  
  # can delete catalog_user
  def can_delete_catalog_user catalog_user
    #puts '+++++++++++++++++++++++ can_delete_catalog_user ++++++++++++++++++++++++++'
    # only if there is permissions to update
    return false unless self.delete_user
    handle_user_permissions_for catalog_user
  end
  
  # permissions based on catalog_user
  def handle_user_permissions_for catalog_user
    #puts '+++++++++++++++++++++++ handle_user_permissions_for ++++++++++++++++++++++++++'
    #puts catalog_user.user.email
    #puts catalog_user.role
    
    # always edit account users
    return true if catalog_user.role        == 'Account User'
                                            
  
    # newer edit the account owner
    return false if catalog_user.role       == 'Account Owner'
    
    # never edit the administrator
    return false if catalog_user.role       == 'Administrator'
    
    # never grand catalog users 
    # access to the account
    return true if catalog_user.role        == 'Catalog User'
    
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
    puts 'ERROR: Unable assign edit permmision for catalog user'
    puts 'In CatalogUser#has_permisions'
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++' 
    false
    
  end
  
  def can_read_catalog_user( catalog_user )

    # supers can se everything
    return true if self.user.role == 'Super'
    
    # never update the administrator
    return false if account.administrator_id == catalog_user.user_id
   
    # always show catalog users
    return true if catalog_user.role    == 'Catalog User'
    
    # no permissions
    false
  end
  
  
  
  
  def access_assets?
    
    return true if self.read_file
    return true if self.read_legal_document
    return true if self.read_financial_document
    return true if self.read_artwork
  end
  
  def add_assets?
    return true if self.create_recording
    return true if self.create_file
    return true if self.create_legal_document
    return true if self.create_financial_document
  end
  
  def grand_all_permissions
    Permissions::TYPES.each do |permission|
      self[permission] = true
    end
    self.save!
  end
  
  def copy_permissions_from_account_user account_user

    
    Permissions::TYPES.each do |permission|
      self[permission]    = account_user[permission]
    end
   
    self.save!
  end
  
  
  
private

  
  
  #def before_destroy
  #
  #end
  
  def flush_cache
    
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['catalog_user', catalog_id, user_id])
    #self.catalog.count_users
    #self.catalog.save!
  end
  
end
