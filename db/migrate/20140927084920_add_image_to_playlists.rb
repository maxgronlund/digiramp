class AddImageToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :playlist_image, :string, default: ''
    Playlist.all.each do |playlist|
      playlist.save!
    end
  end
end
