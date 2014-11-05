class SanitizeWidgets < ActiveRecord::Migration
  def change
    
    Widget.find_each do |widget|
      unless Playlist.exists?(widget.playlist_id)
        widget.destroy!
      end
    end
    
    
  end
end
