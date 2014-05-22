class PlaylistKeysController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  def edit
    @playlist_key = PlaylistKey.cached_find(params[:id])
  end

  def show
  end
  
  def update
    
    @playlist_key = PlaylistKey.cached_find(params[:id])
    
    if params[:playlist_key][:secure_access] == false

      params[:playlist_key].delete :password
      params[:playlist_key].delete :password_confirmation
    end
    if @playlist_key.update_attributes(playlist_key_params)
      redirect_to account_playlist_path( @account, @playlist_key.playlist)
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
