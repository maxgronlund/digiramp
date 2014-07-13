class AddSubjectToMailCampaigns < ActiveRecord::Migration
  def change
    remove_column :mail_campaigns, :from_title
    add_column :mail_campaigns, :subject, :string
  end
end
