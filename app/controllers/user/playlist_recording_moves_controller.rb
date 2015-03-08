class User::PlaylistRecordingMovesController < ApplicationController
  before_filter :access_user
  def update

    @playlist                      = Playlist.cached_find(params[:playlist_id])
    playlists_recording_to_move_up = PlaylistsRecordings.cached_find(params[:playlists_recording_id])

    # make sure the playlist is ordered, an item may be deleted
    @playlist.playlists_recordings.order(:position).each_with_index do |playlists_recording, index|
      playlists_recording.position = index * 2
      playlists_recording.position -= 3 if playlists_recording.id == playlists_recording_to_move_up.id 
      playlists_recording.save!
    end
    
  
  end
end
