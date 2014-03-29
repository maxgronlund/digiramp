class PrivatePlaylistsController < ApplicationController
  def index
  end

  def show
    
    @account      = Account.cached_find(params[:account_id])
    @playlist_key = PlaylistKey.where(password: params[:id]).first
    @playlist     = @playlist_key.playlist
    @playlist_items   = @playlist.playlist_items

    
  end
end
