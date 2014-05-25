# account user
# permissions copied to the account with lists for easy access


class AccountUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :customer_events
  

  validates_uniqueness_of :user_id, :scope => :account_id
  

  ROLES = ["Account Owner", "Administrator", "Client", "Super"]
  
  include PgSearch
  pg_search_scope :search_account_user, against: [:name, :email, :note, :phone], :using => [:tsearch]
  
  after_commit :update_cache
  before_save :update_uuids
  before_destroy :update_uuids

  
  scope :supers,          ->  { where.not( role: 'Super').order("id asc")  }
  scope :clients,         ->  { where( role: 'Client').order("id asc")  }
  scope :administrators,  ->  { where( role: 'Administrator').order("id asc")  }


  def update_cache
    flush_cache
    update_account_white_lists
    # update uuid on the account
    account.save!
  end
  
  def grand_all_permissions
    #  permissions 
    AccountPermissions::PERMISSION_TYPES.each do |permission_type|
      permission = permission_type.gsub('_ids', '')
      eval "self.#{permission}  = true" 
    end
    self.save!
    AccountPermissions.update_user self, self.account
  end
  
  def update_account_white_lists
    AccountPermissions.update_user self, self.account
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
  
  def can_access_work common_work
    common_work.recordings.each do |recording|
      return true if recording.read_common_work_ids.include?  self.user_id
    end
    return false
    
  end
  
  #def can_access_assets?
  #  access_to_all_recordings || access_to_all_common_works
  #end
  #
  #def can_collect?
  #  access_to_collect || administrator?
  #end
  #
  #def has_access_to_all_documents? 
  #  access_to_all_documents || administrator?
  #end
  #
  #def has_access_to_all_rights?
  #  access_to_all_rights || administrator?
  #end
  #
  #def has_access_to_all_common_works?
  #  access_to_all_common_works || administrator?
  #end
  
  

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
  



private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['account_user', account_id, user_id])
  end
  
  def update_uuids
    AccountCache.update_users_uuid self.account
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
end
