class PlaylistsController < ApplicationController
  #include AccountsHelper
  #before_filter :access_account
  before_filter :get_user, only: [:show, :index, :edit, :update]
  def index
    #@playlists = @user.playlists
    #if @authorized  
    #  @recordings =   Recording.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
    #else
    #  @recordings =  @user.recordings.published.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
    #end
  end

  def show
    @playlist     = Playlist.cached_find(params[:id])
  end

  def edit
    @playlist = Playlist.cached_find(params[:id])
    #@recordings   = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
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
