class UpdatePlaylistImage < ActiveRecord::Migration
  def change
    Playlist.find_each do |playlist|
      if playlist.playlist_image
        begin
          playlist.playlist_image.recreate_versions!
          playlist.save!
        rescue
        end
      end
    end
  end
end
