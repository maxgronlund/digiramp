class AddEmailFieldsToCampaignEvents < ActiveRecord::Migration
  def change
    add_column :campaign_events, :layout, :string
    add_column :campaign_events, :subject, :string
    add_column :campaign_events, :teaser, :string
    add_column :campaign_events, :image, :string
    add_column :campaign_events, :image_link, :string
    add_column :campaign_events, :heading_1, :string
    add_column :campaign_events, :sub_heading_1, :string
    add_column :campaign_events, :body_1, :text
    add_column :campaign_events, :heading_2, :string
    add_column :campaign_events, :sub_heading_2, :string
    add_column :campaign_events, :body_2, :text
    add_reference :campaign_events, :playable, polymorphic: true, index: true
  end
end
