class MoodTag < ActiveRecord::Base
  belongs_to :recording
  belongs_to :mood
  belongs_to :mood_tagable, polymorphic: true
  
  after_commit :flush_cache
  after_create :count_moods_up
  before_destroy :count_moods_down 
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def count_moods_up
    self.mood.recordings_count += 1
    self.mood.save!
  end
  
  def count_moods_down
    self.mood.recordings_count -= 1
    self.mood.save!
  end
  
  
end
