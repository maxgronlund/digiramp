class AddStatusToUserConfigurations < ActiveRecord::Migration
  def change
    add_column :user_configurations, :status, :integer, default: 0
    UserConfiguration.update_all(status: 0)
  end
end
