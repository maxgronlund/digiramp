class MailListSubscriber < ActiveRecord::Base
  belongs_to :user
  belongs_to :email_group
end
