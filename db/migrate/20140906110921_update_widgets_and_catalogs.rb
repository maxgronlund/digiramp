class UpdateWidgetsAndCatalogs < ActiveRecord::Migration
  def up
    add_column :catalogs, :user_id, :integer
    add_column :catalogs, :default_playlist_id, :integer
    add_index  :catalogs, :default_playlist_id
    add_index  :catalogs, :user_id
    
    add_column :playlists, :default_widget_id, :integer
    
    
    PlaylistKey.destroy_all
    Playlist.destroy_all
    Widget.destroy_all

    #Catalog.all.each do |catalog|
    #  playlist = catalog.default_playlist
    #  catalog.with_lock do
    #    catalog.user_id     = catalog.account.user_id
    #    catalog.default_playlist_id = playlist.id
    #    catalog.save!
    #  end
    #  catalog.default_widget
    #end
    #
    #Catalog.all.each do |catalog|
    #  widget = catalog.default_widget
    #  widget.playlist_id = catalog.default_playlist_id
    #  widget.account_id = catalog.account_id
    #  widget.save!
    #  widget
    #end
    
    Catalog.all.each do |catalog|
      catalog.user_id     = catalog.account.user_id
      catalog.save!
      catalog.update_widget
    end
    
  end
  
  def down
    remove_column :catalogs, :user_id, :integer
    remove_column :catalogs, :default_playlist_id, :integer
    remove_column :playlists, :default_widget_id
  end
end
