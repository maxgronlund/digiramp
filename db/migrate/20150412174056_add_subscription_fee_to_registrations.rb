class AddSubscriptionFeeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :subscription_fee, :decimal
  end
end
