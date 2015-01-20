class CreateCampaignEvents < ActiveRecord::Migration
  def change
    create_table :campaign_events do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.string :title
      t.text :body
      t.string :campaign_event_type
      t.string :status

      t.timestamps
    end
  end
end
