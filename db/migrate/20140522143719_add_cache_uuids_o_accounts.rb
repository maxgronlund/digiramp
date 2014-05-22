class AddCacheUuidsOAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :works_cache_key
    remove_column :accounts, :rec_cache_version
    remove_column :accounts, :customer_cache_version
    remove_column :accounts, :playlists_cache_key
    
    
    
    remove_column :common_works, :file_size
    
    
    
    
  end
end
