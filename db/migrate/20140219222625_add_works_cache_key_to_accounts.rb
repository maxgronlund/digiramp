class AddWorksCacheKeyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :works_cache_key, :integer, default: 0
  end
end
