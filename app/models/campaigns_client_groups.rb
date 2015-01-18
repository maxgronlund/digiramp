class CampaignsClientGroups < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :client_group
end
