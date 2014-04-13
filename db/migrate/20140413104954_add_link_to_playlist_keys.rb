class AddLinkToPlaylistKeys < ActiveRecord::Migration
  def change
    add_column :playlist_keys, :playlist_url, :string, default: ''
    
    PlaylistKey.all.each do |playlist_key|
      playlist_key.playlist_url = playlist_key.password
      playlist_key.save!
    end
  end
end
