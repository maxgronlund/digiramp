class RemoveAccountPrices < ActiveRecord::Migration
  def change
    remove_column :accounts, :subscription_fee
    remove_column :accounts, :special_subscription_fee
    remove_column :accounts, :recurring
    remove_column :accounts, :period
    
    drop_table :account_prices

  end
end
