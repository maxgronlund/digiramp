class AddPositionToPlaylistsRecordings < ActiveRecord::Migration
  def change
    add_column :playlists_recordings, :position, :integer
    
    
    Playlist.find_each do |playlist|

      if playlists_recordings = playlist.playlists_recordings
        
        playlists_recordings.each_with_index do |playlists_recording, index|
          playlists_recording.position = index
          playlists_recording.save!
        end
        
      end
      
    end
    
  end
end
