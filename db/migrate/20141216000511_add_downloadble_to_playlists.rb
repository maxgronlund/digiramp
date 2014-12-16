class AddDownloadbleToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :downloadable, :boolean, default: false
    add_column :playlists, :downloadkey, :string, default: ''
    
    Playlist.find_each do |playlist|
      playlist.downloadable = false
      playlist.downloadkey = UUIDTools::UUID.timestamp_create().to_s
      playlist.save
    end
  end
end
