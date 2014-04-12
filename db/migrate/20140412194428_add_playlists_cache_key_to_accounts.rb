class AddPlaylistsCacheKeyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :playlists_cache_key, :integer, default: 0
    remove_column :account_users, :version
    add_column :account_users, :administrate_playlists, :boolean, default: false

  end
end
