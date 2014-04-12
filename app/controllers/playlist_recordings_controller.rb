class PlaylistRecordingsController < ApplicationController
  
  before_filter :there_is_access_to_the_account
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
                 
    # use ajax here
    redirect_to :back
    
    
    
  end
  
  def add_all
    #@catalog   = Catalog.cached_find(params[:catalog_id])
    #
    #if @recordings  = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
    #  @recordings.each do |recording|
    #    CatalogItem.where(catalog_id: @catalog.id, 
    #                      catalog_itemable_id: recording.id, 
    #                      catalog_itemable_type: recording.class.name)
    #                .first_or_create( catalog_id: @catalog.id, 
    #                                  catalog_itemable_id: recording.id, 
    #                                  catalog_itemable_type: recording.class.name)
    #  end
    #end
    #
    redirect_to :back
    
  end
  
  def destroy
    @recording = Recording.cached_find(params[:id])
    @playlist   = Playlist.cached_find(params[:playlist_id])
    
    playlist_item = PlaylistItem.where(playlist_id: @playlist.id, playlist_itemable_id: @recording.id, playlist_itemable_type: @recording.class.name).first
    playlist_item.destroy
    redirect_to :back
    
  end
  
  
  
end
