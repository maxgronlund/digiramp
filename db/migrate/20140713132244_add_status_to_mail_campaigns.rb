class AddStatusToMailCampaigns < ActiveRecord::Migration
  def change
    add_column :mail_campaigns, :status, :string, default: ''
  end
end
