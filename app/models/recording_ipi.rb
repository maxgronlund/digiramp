class RecordingIpi < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :recording
  
  ROLES  = [ "Administrator",
             "Owner",
             "Artist",
             "Performers",
             "Producer",
             "Executive Producer",
             "Arranger",
             "Mixer",
             "Musician",
             "Vocalist",
             "Orchestrator",
             "Engineer",
             "Labels",
             "Production Companies",
             "Recording Studio",
             "Participant",
             "Sound Recording Copyright",
             "Representative",
             "Other"
           ]

  after_commit :flush_cache
  before_save :attach_user
  
  
  
  def attach_user
    if user = User.where(uuid: self.user_uuid).first
      self.user_id = user.id
      self.name   = user.name
    end
  end
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end




