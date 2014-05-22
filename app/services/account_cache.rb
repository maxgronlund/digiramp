class AccountCache

  def initialize
  end
  
  def self.update_works_uuid account
    account.works_uuid = UUIDTools::UUID.timestamp_create().to_s
    account.save
  end
  
  def self.update_recordings_uuid account
    account.recordings_uuid = UUIDTools::UUID.timestamp_create().to_s
    account.save
  end
  
  def self.update_customers_uuid account
    account.customers_uuid = UUIDTools::UUID.timestamp_create().to_s
    account.save
  end
  
  def self.update_playlists_uuid account
    account.playlists_uuid = UUIDTools::UUID.timestamp_create().to_s
    account.save
  end
  
  def self.update_users_uuid account
    account.users_uuid = UUIDTools::UUID.timestamp_create().to_s
    account.save
  end
  
  def self.update_pro_affilications_uuid
    admin = Admin.cached_find(1)
    admin.pro_affilications_uuid = UUIDTools::UUID.timestamp_create().to_s 
    admin.save!
  end
  
  
  
end


# AccountCache.update_works_uuid account
# AccountCache.update_recordings_uuid account
# AccountCache.update_customers_uuid account
# AccountCache.update_playlists_uuid account
# AccountCache.update_users_uuid account