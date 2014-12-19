class AddPublicOpportunityToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :public_opportunity, :boolean, default: false
    remove_column :music_requests, :oppertunity_id
  end
end
