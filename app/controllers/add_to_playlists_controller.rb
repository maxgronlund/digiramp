class AddToPlaylistsController < ApplicationController
  def new
  end

  def create
    
    recording_id = params[:recording][:recording_id]
    playlist_id  = params[:recording][:playlist]
    
    PlaylistsRecordings.where(
                             playlist_id: playlist_id, 
                             recording_id: recording_id)
                  .first_or_create(
                             playlist_id: playlist_id, 
                             recording_id: recording_id)
                      
    @recording = Recording.cached_find(recording_id)
    @playlist = Playlist.cached_find(playlist_id)
    
    
  end
  
  def destroy
      
    
    render nothing: true
  end
  
end
