class PlaylistsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    
  end

  def show
    @playlist     = Playlist.cached_find(params[:id])
    #@recordings   = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end

  def edit
    @playlist = Playlist.cached_find(params[:id])
    @recordings   = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end

  def update
    @playlist = Playlist.cached_find(params[:id])
    @playlist.update_attributes(playlist_params)
    redirect_to account_playlist_path( @account, @playlist )
  end
  
  def destroy
    @playlist = Playlist.cached_find(params[:id])
    @playlist.destroy
    @account.playlists_cache_key += 1
    @account.save!
    redirect_to account_playlists_path( @account )
  end
  
private  

  def playlist_params
     params.require(:playlist).permit!
  end
end
