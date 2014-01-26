class MusicOpportunity < ActiveRecord::Base
  belongs_to :account
  has_many :music_requests
  has_many :permissions, as: :permissionable
  has_one :activity_log
  has_many :activity_events, as: :activity_eventable
  has_many :music_opportunity_invitations
  
  validates :title, :presence => true
  
  PROJECT_TYPES = ["film", "tv show", "movie"]
  

  

end
