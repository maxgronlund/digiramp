class AddClientGroupIdToMailCampaigns < ActiveRecord::Migration
  def change
    add_reference :mail_campaigns, :client_group, index: true
  end
end
