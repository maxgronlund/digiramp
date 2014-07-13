class MailCampaign < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :mail_layout
end
