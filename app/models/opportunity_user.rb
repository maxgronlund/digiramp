class OpportunityUser < ActiveRecord::Base
  belongs_to    :user
  belongs_to    :opportunity
  has_many      :music_submissions
  
end
