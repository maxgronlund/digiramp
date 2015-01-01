class AddDefaultImagesToPlaylists < ActiveRecord::Migration
  def change
    count = 0
    Playlist.find_each do |playlist|
      begin
        playlist.playlist_image.recreate_versions!
      rescue
        count = 0 if count > 14
        if count < 10
          id = '0' + count.to_s 
        else
          id = count.to_s 
        end
        playlist.playlist_image = File.open(Rails.root.join('app', 'assets', 'images', "playlists/default_#{id}.jpg"))
        playlist.playlist_image.recreate_versions!
        playlist.save!
        count += 1
      end
    end

  end
end
