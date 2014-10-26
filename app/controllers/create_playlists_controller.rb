class CreatePlaylistsController < ApplicationController
  def new

    @recording = Recording.cached_find(params[:recording_id])

  end
  
  def create

    recording_id = params[:playlist][:recording_id]
    @recording  = Recording.cached_find(recording_id)
    
    
    params[:playlist].delete :recording_id
    playlist      = Playlist.create(playlist_params)
    @playlists    = current_user.playlists

    
  end
  
  def playlist_params
     params.require(:playlist).permit!
  end
  
  
end
