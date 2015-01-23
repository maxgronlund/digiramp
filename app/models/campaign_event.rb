class CampaignEvent < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  belongs_to :account
  
  STATUS      = ['Draft', 'Delivered']
  #EVENT_TYPE  = ['Email', 'Promote song', 'Promote playlist', 'Promote opportunity', 'Promote my profile']
  EVENT_TYPE  = {'Email'.to_sym => 'email', 
                 'Promote song'.to_sym => 'promote_song' , 
                 'Promote playlist'.to_sym => 'promote_playlist', 
                 'Promote my profile'.to_sym => 'promote_profile' }
  
end
