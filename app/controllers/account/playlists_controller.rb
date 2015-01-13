class Account::PlaylistsController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  def index
    
  end
  

  def show
    forbidden unless current_account_user.read_playlist?
    begin
      @playlist     = Playlist.cached_find(params[:id])
    rescue
      not_found params
    end
    #@recordings   = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end
  
  def new
    @playlist = Playlist.new
  end

  def edit
    @playlist     = Playlist.cached_find(params[:id])
    #@recordings   = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end

  def update
    @playlist = Playlist.cached_find(params[:id])
    @playlist.update(playlist_params)
    redirect_to account_account_playlist_path( @account, @playlist )
  end
  
  def destroy
    @playlist = Playlist.cached_find(params[:id])
    @playlist.destroy

    redirect_to account_account_playlists_path(@account)
  end
  
  def create
    forbidden unless current_account_user.create_playlist?
    @playlist = Playlist.create(playlist_params)
    redirect_to account_account_playlist_path(@account, @playlist)
  end
  
private  

  def playlist_params
     params.require(:playlist).permit!
  end
end
