class ClientGroup < ActiveRecord::Base
  belongs_to :account
  

  
  has_and_belongs_to_many :clients
  
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
