class FollowerEventUser < ActiveRecord::Base
  belongs_to :follower_event
  belongs_to :user
end
