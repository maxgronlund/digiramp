class MusicRequest < ActiveRecord::Base
  belongs_to :opportunity, touch: true
  has_many :music_submissions, dependent: :destroy
  validates :title, :presence => true
  #has_many :music_submissions
  #has_many :music_opportunity_submitters
  #has_one :activity_log
  #has_many :activity_events, as: :activity_eventable
  #has_many :mood_tags,        as: :mood_tagable
  #has_many :instrument_tags,  as: :instrument_tagable
  #has_many :genre_tags,       as: :genre_tagable
  
  after_commit :flush_cache
  #before_destroy :destroy_music_submissions
  
  def duration_text
    duration.try(:strftime, "%H:%M:%S")
  end
  
  def duration_text=(duration)
    self.duration = Time.zone.parse(duration) if duration.present?
  end
  
  def recording
    Recording.where(id: self.recording_id).first
  end
  
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { where(id: id).first }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
