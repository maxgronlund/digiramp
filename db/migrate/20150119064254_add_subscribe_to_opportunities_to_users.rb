class AddSubscribeToOpportunitiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_to_opportunities, :boolean, default: true
  end
end
