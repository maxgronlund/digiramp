class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :inviteable, polymorphic: true
  
  has_many :activity_events, as: :activity_eventable
end
