class Oppertunity < ActiveRecord::Base
  
  has_many :music_requests, dependent: :destroy
  belongs_to :account
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end

