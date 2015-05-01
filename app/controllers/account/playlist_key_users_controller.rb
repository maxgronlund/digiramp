class Account::PlaylistKeyUsersController < ApplicationController
  
  include AccountsHelper
  before_action :access_account
  
  def index
    @playlist           = Playlist.cached_find(params[:playlist_id])
    @playlist_key       = PlaylistKey.cached_find(params[:playlist_key_id])
    @playlist_key_user  = PlaylistKeyUser.where(playlist_key_id: @playlist_key.id).first_or_create(playlist_key_id: @playlist_key.id)
    @client_groups      = @account.client_groups
  end
  
  def create
    
    emails = params[:playlist_key_user][:emails]

    params[playlist_key_user_params].delete :emails if emails
    @playlist_key_user = PlaylistKeyUser.create(playlist_key_user_params)
    

    
    redirect_to :back
  end
  
  def update
    
    emails = params[:playlist_key_user][:emails]

    params[playlist_key_user_params].delete :emails if emails
    @playlist_key_user = PlaylistKeyUser.find(params[:id])
    @playlist_key_user = @playlist_key_user.update(playlist_key_user_params)
    

    
    redirect_to :back
  end

  
private

  def playlist_key_user_params
    params.require(:playlist_key_user).permit!
  end
end
