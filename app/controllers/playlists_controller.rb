class PlaylistsController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  def index
    
  end

  def show
    @playlist     = Playlist.cached_find(params[:id])
  end

  def edit
    @playlist = Playlist.cached_find(params[:id])
    @recordings   = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end

  def update
    @playlist = Playlist.cached_find(params[:id])
    @playlist.update_attributes(playlist_params)
    redirect_to account_playlist_path( @account, @playlist )
  end
  
  def destroy
    @playlist = Playlist.cached_find(params[:id])
    @playlist.destroy

    redirect_to account_playlists_path( @account )
  end
  
private  

  def playlist_params
     params.require(:playlist).permit!
  end
end
