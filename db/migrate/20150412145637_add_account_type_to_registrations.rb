class AddAccountTypeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :account_type, :string
  end
end
