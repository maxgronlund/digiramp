class MusicSubmission < ActiveRecord::Base
  belongs_to :recording
  belongs_to :music_request
  belongs_to :user
  
end
