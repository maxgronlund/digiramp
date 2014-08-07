class Account::PlaylistKeysController < ApplicationController
  
  include AccountsHelper
  before_filter :access_account
  
  def index
    @playlist = Playlist.cached_find(params[:playlist_id])
    @playlist_keys = @playlist.playlist_keys.where(default: false)
  end
  def edit
    @playlist_key = PlaylistKey.cached_find(params[:id])
    if @playlist_key.default
      redirect_to account_account_playlist_path(@account, @playlist_key.playlist)
    end
  end

  def show
  end
  
  def create
    params[:playlist_key][:default] == false
  end
  
  def update
    
    @playlist_key = PlaylistKey.cached_find(params[:id])
    
    if params[:playlist_key][:secure_access] == false
      params[:playlist_key].delete :password
      params[:playlist_key].delete :password_confirmation
    end
    if @playlist_key.update_attributes(playlist_key_params)
      redirect_to account_account_playlist_path( @account, @playlist_key.playlist)
    else
    
      flash[:danger] = { title: "Please check password: ", body: "If Password is enabled password and password confirmation has to be filled in and macth" }
      redirect_to :back
    end

  end
  
private

  def playlist_key_params
    params.require(:playlist_key).permit!
  end
end
