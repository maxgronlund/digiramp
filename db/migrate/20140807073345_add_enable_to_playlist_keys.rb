class AddEnableToPlaylistKeys < ActiveRecord::Migration
  def change
    add_column :playlist_keys, :enable, :boolean
    add_column :playlist_keys, :title,  :string
    add_column :playlist_keys, :body,  :text
  end
end
