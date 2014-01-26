class SceneTrackRequest < ActiveRecord::Base
  belongs_to :music_opportunity
  has_many :scene_track_submissions
  has_one :activity_log
  has_many :activity_events, as: :activity_eventable
  has_many :mood_tags,        as: :mood_tagable
  has_many :instrument_tags,  as: :instrument_tagable
  has_many :genre_tags,       as: :genre_tagable
  
  def duration_text
    duration.try(:strftime, "%H:%M:%S")
  end
  
  def duration_text=(duration)
    self.duration = Time.zone.parse(duration) if duration.present?
  end
  
  
end
