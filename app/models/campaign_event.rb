class CampaignEvent < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  belongs_to :account
  
  STATUS      = ['Draft', 'Delivered']
  EVENT_TYPE  = ['Email', 'Promote a song', 'Promote a playlist', 'Promote a opportunity', 'Promote a my profile']
  
end
