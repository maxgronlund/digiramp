class Comment < ActiveRecord::Base
  belongs_to :user
  has_many :activity_events, as: :activity_eventable

end
