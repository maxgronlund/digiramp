class AddAccountIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :account_id, :integer
    add_index :registrations, :account_id
  end
end
