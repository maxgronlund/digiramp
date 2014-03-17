class AddCustomerCacheVersionToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :customer_cache_version, :integer, default: 0
    Account.all.each do |account|
      account.customer_cache_version = 2
      account.save!
    end
  end
end
