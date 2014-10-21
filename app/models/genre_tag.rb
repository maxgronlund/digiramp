class GenreTag < ActiveRecord::Base
  #belongs_to :recording
  belongs_to :genre
  belongs_to :genre_tagable, polymorphic: true
  
  after_commit :flush_cache
  
  after_create :count_genre_up
  before_destroy :count_genre_down 

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  

private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def count_genre_up
    self.genre.recordings_count += 1
    self.genre.save!
  end
  
  def count_genre_down
    self.genre.recordings_count -= 1
    self.genre.save!
  end
end
