class AddDefaultWidgetKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_widget_key, :string
    add_column :users, :default_playlist_id, :integer
    
    add_index :users, :default_widget_key
    add_index :users, :default_playlist_id
  end
end
