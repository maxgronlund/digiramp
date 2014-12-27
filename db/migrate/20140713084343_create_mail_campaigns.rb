class CreateMailCampaigns < ActiveRecord::Migration
  def change
    create_table :mail_campaigns do |t|
      t.belongs_to :account, index: true
      t.belongs_to :user, index: true
      t.belongs_to :campaign_group, index: true
      t.string :title
      t.string :from_email
      t.string :from_title
      t.belongs_to :mail_layout, index: true
      t.text :subscribtion_message
      t.date  :send_date

      t.timestamps
    end
  end
end
