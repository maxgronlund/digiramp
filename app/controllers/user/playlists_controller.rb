class User::PlaylistsController < ApplicationController
  #include AccountsHelper
  #before_action :access_account
  before_action :access_user
  
  
 

  def edit
    @playlist              = Playlist.cached_find(params[:id])
    #@playlists_recordings   = @playlist.playlists_recordings
  end

  def update
    
    @playlist = Playlist.cached_find(params[:id])
    
    
    if @playlist.update_attributes(playlist_params)
      @playlist.check_default_image
      #redirect_to user_playlist_path( @user, @playlist )
      @recordings   = @playlist.recordings
      
      redirect_to user_playlist_path( @user, @playlist )
    else
      redirect_to edit_user_user_playlist_path( @user, @playlist )
    end
  end
  
  
private 

  

  def playlist_params
     params.require(:playlist).permit!
  end
end
