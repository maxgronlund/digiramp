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
  before_save   :update_uuids
  after_create  :attach_to_account_user
  #before_destroy :before_destroy

  
  scope :invited,           ->  { where.( role: 'Catalog User').order("email asc")  }
  scope :account_users,     ->  { where.( role: 'Account User').order("email asc")  }
  scope :super_users,       ->  { where.( role: 'Super User').order("email asc")  }
  scope :account_owners,    ->  { where.( role: 'Account Owner').order("email asc")  }
  
  # catalog users comes in four flavors
  # 1: Catalog User, this role is set when the catalog user is invited to a catalog
  # 2: Account User, this role is set when a user is invited to an account
  # 3: Super User, this role is set for all super users
  # 4: Account owner this role is set for the account owner
  ROLE = ['Catalog User', 'Account User', 'Super User', 'Account Owner']
  
  def update_uuids
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_where(catalog_id, user_id)
    Rails.cache.fetch([ 'catalog_user', catalog_id, user_id]) { where( catalog_id: catalog_id, 
                                                                    user_id: user_id ).first 
                                                               }
  end
  
  
  # when a catalog user is created, it's attached to an account_user
  # so the persona can access the hosting account true the account user
  def attach_to_account_user
    # find or create an account user for all catalog users
    account_user = AccountUser.where( account_id: self.account_id, 
                                      user_id: self.user_id)
                              .first_or_create( account_id: self.account_id, 
                                                user_id: self.user_id,
                                                role: 'Catalog User',
                                                email: self.user.email)
                                                
    account_user.read_catalog = true   
    account_user.save!                                       
    self.account_user_id  = account_user.id
    self.role             = 'Super User' if self.user.role == 'Super'
    self.save!
    
    
    if account_user.user.super?
      grand_all_permissions 
    #else
    #  copy_permissions_from_account_user account_user
    end
  end
  
  def access_assets?
    return true if self.read_file
    
  end
  
  def add_assets?
    return true if self.create_recording
    return true if self.create_file
    return true if self.create_legal_document
    return true if self.create_financial_document
  end
  
  def grand_all_permissions
    Permissions::TYPES.each do |permission|
      eval "self.#{permission} = true"
    end
    self.save!
  end
  
  def copy_permissions_from_account_user account_user
    Permissions::TYPES.each do |permission|
      eval "self.#{permission} = account_user.#{permission}"
    end
    
    # update role if needed
    copy_role_from_account_user account_user
    
  end
  
  def copy_role_from_account_user account_user
    self.role   =  'Account User' if account_user.role == 'Account User'
    self.role   =  'Catalog User' if account_user.role == 'Catalog User'
    self.role   =  'Super User'   if account_user.role == 'Super'
    self.save!
  end
  
private

  
  
  def before_destroy

  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['catalog_user', catalog_id, user_id])
  end
  
end
