class AddCardholdersNameToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cardholders_name, :string
  end
end
