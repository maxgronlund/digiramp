class Bug < ActiveRecord::Base
  belongs_to :user
  has_many :activity_events, as: :activity_eventable
  mount_uploader :image, ImageUploader
  STATUS = ["new", "assigned", "in progress", "resolved", "closed"]
  PRIORITY = ["high", "midt", "low"]
end
