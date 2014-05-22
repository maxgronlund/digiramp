class AddCacheUuidsOAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :works_cache_key
    remove_column :accounts, :rec_cache_version
    remove_column :accounts, :customer_cache_version
    remove_column :accounts, :playlists_cache_key
    
    add_column :accounts, :works_uuid,        :string, default: 'first love 727'
    add_column :accounts, :recordings_uuid,   :string, default: 'first love 727'
    add_column :accounts, :customers_uuid,    :string, default: 'first love 727'
    add_column :accounts, :playlists_uuid,    :string, default: 'first love 727'
    add_column :accounts, :users_uuid,        :string, default: 'first love 727'
    
    remove_column :common_works, :file_size
    
    
    
    
  end
end
