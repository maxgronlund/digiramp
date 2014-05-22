class PlaylistRecordingsController < ApplicationController
  
  include AccountsHelper
  before_filter :access_to_account
  def index
     @playlist         = Playlist.cached_find(params[:playlist_id])
     @recordings       = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end
  
  def new
    
    @recording  = Recording.cached_find(params[:recording])
    @playlist   = Playlist.cached_find(params[:playlist_id])
    
    PlaylistItem.where( playlist_id: @playlist.id, 
                        playlist_itemable_id: @recording.id, 
                        playlist_itemable_type: @recording.class.name)
               .first_or_create(playlist_id: @playlist.id, 
                                playlist_itemable_id: @recording.id, 
                                playlist_itemable_type: @recording.class.name)

    
    # ajax here
    @prepend_tag = "#remove_recording_" + @recording.id.to_s  + "_from_playlist"
    @remove_tag  = "#add_recording_"    + @recording.id.to_s  + "_to_playlist"

  end
  
  def add_all
     playlist   = Playlist.cached_find(params[:playlist_id])
    
    if recordings  = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
      recordings.each do |recording|
        PlaylistItem.where( playlist_id: playlist.id, 
                            playlist_itemable_id: recording.id, 
                            playlist_itemable_type: recording.class.name)
                   .first_or_create(playlist_id: playlist.id, 
                                    playlist_itemable_id: recording.id, 
                                    playlist_itemable_type: recording.class.name)
      end
    end
    
    redirect_to :back
    
  end
  
  def destroy
    @recording  = Recording.cached_find(params[:id])
    @playlist   = Playlist.cached_find(params[:playlist_id])
    
    playlist_item = PlaylistItem.where(playlist_id: @playlist.id, playlist_itemable_id: @recording.id, playlist_itemable_type: @recording.class.name).first
    playlist_item.destroy
    
    # ajax here
    @prepend_tag = "#add_recording_"    + @recording.id.to_s  + "_to_playlist"
    @remove_tag  = "#remove_recording_" + @recording.id.to_s  + "_from_playlist"
    
    
  end
  
  
  
end
