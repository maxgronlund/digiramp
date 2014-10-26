class RemoveFromPlaylistsController < ApplicationController
  def destroy
    @recording_id = params[:recording]
    
    
    @playlist = Playlist.cached_find(params[:id])
    @recording = Recording.cached_find(@recording_id)
    recording_playlist = PlaylistsRecordings.where(playlist_id: @playlist.id, recording_id: @recording_id).first
    recording_playlist.destroy
    
  end
end
