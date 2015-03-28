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
  has_many :user_credits, as: :ipiable, dependent: :destroy
  
  after_create :attach_user_credits
  after_update :attach_user_credits
  #before_destroy :remove_user_credits
  
  def attach_user_credits
    if self.user
      UserCredit
      .where(ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)
      .first_or_create(title: self.recording.title, ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)
    end
  end
  
  #def remove_user_credits
  #  begin
  #    UserCredit.where( ipiable_id: self.id, ipiable_type: self.class.name).destroy_all
  #  rescue
  #  end
  #end
  
  def attach_user
    if user = User.where(email: self.email).first
      self.user_id = user.id
      self.name    = user.user_name
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




