class ActivityLog < ActiveRecord::Base
  belongs_to :account
  has_many :activity_events
end
