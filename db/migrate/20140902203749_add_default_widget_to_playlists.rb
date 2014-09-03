class AddDefaultWidgetToPlaylists < ActiveRecord::Migration
  def up
    
    # clean up
    Catalog.where(account_id: nil).destroy_all
    
    add_column :playlists, :user_id, :integer
    add_index  :playlists, :user_id
    
    add_column :widgets, :widget_theme_id, :integer
    add_index  :widgets, :widget_theme_id
    
    add_column :playlists, :default_widget_key, :string
    add_index  :playlists, :default_widget_key
    
    add_column :catalogs,  :default_widget_key, :integer
    add_index  :catalogs,  :default_widget_key
   
    
    
  end
  
  def down

    remove_column :playlists, :user_id
    remove_column :playlists, :default_widget_key
    remove_column :widgets,   :widget_theme_id
    remove_column :catalogs,  :default_widget_key
    
  end
end
