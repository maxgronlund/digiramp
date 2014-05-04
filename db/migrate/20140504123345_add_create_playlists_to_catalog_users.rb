class AddCreatePlaylistsToCatalogUsers < ActiveRecord::Migration
  def change
    add_column :catalog_users, :create_playlists, :boolean, default: false
  end
end
