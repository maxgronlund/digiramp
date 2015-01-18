class ClientGroup < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  

  
  has_and_belongs_to_many :clients
  
  has_and_belongs_to_many :campaigns
  
  
  # a client group can be used for many playlist
  has_and_belongs_to_many :playlist_key_users
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
end
