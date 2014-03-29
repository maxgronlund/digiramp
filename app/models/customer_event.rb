class CustomerEvent < ActiveRecord::Base
  belongs_to :account
  belongs_to :account_user
  belongs_to :playlist_key
  
  after_commit :flush_cache
  
  EVENT_TYPES = { private_playlist: "Private Playlist", 
                  invite_to_common_work: "Invite to Common Work", 
                  invite_to_recording: "Invite To Recording",
                  invite_to_account:  "Invite to Account", 
                  phone_call: "Phone Call", 
                  email: "Email"}
                  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end 
  
private                  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end


