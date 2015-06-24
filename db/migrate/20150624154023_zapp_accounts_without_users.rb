class ZappAccountsWithoutUsers < ActiveRecord::Migration
  def change
    remove_column :users, :account_id
    
  end
end
