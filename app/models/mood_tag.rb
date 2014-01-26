class MoodTag < ActiveRecord::Base
  belongs_to :recording
  belongs_to :mood
  belongs_to :mood_tagable, polymorphic: true
end
