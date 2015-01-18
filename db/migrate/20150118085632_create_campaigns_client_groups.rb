class CreateCampaignsClientGroups < ActiveRecord::Migration
  def change
    create_table :campaigns_client_groups do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :client_group, index: true

      t.timestamps
    end
  end
end
