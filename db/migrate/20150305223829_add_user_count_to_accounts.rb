class AddUserCountToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :user_count, :integer
    
    Account.find_each do |account|
      account.count_users
    end
  end
end
