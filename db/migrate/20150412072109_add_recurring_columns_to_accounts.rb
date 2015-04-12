class AddRecurringColumnsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :recurring, :boolean
    add_column :accounts, :period, :string
    add_column :accounts, :cycles, :integer
  end
end
