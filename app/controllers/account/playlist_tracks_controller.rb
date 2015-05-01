class Account::PlaylistTracksController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  
  def index
    @playlist = Playlist.cached_find(params[:playlist_id])
  end
  
  # called from DigiWhamsController as js 
  def show
    
    @playlist   = Playlist.cached_find(params[:playlist_id])
    @recordings = @account.recordings
  end
end
