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
    
    channel = 'digiramp_radio_' + current_user.email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'RECORDING ADDED', 
                                          "message" => "#{@recording.title} is added to #{@playlist.title}", 
                                          "time"    => '7000', 
                                          "sticky"  => 'false', 
                                          "image"   => 'success'
                                          })
    
    
  end
  
  def destroy
      
    
    render nothing: true
  end
  
end
