class PlaylistsRecordings < ActiveRecord::Base
  belongs_to :recording
  belongs_to :playlist
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end

