class AddDefaultToPlaylistKeys < ActiveRecord::Migration
  def change
    add_column :playlist_keys, :default, :boolean
    
    PlaylistKey.where(title: 'Default Key').destroy_all
    
    Playlist.all.each do |playlist|
      if playlist.account_id.nil?
        playlist.destroy
      else
        playlist.playlist_keys.each do |playlist_key|
          playlist_key.default = false 
          playlist_key.save!
        end
        playlist.add_default_key
        
      end
    end
  end
end
