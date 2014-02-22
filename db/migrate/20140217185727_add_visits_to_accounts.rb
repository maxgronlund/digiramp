class AddVisitsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :visits, :integer, default: 0
    add_column :users, :avatar_url, :string
  end
end
