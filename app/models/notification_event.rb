class NotificationEvent < ActiveRecord::Base
  # #attr_accessible :title, :body
  has_many :notifications, dependent: :destroy
end
