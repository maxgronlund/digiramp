class RecordingPermissionsController < ApplicationController
  #before_filter :there_is_access_to_the_account
  #def index
  #  if current_user.can_administrate @account
  #    @can_manage     = true
  #  end
  #end
  
  def show
    @recording            = Recording.cached_find(params[:id])
    @account              = @recording.account
    @common_work          = CommonWork.cached_find(@recording.common_work_id)
    if current_user.can_administrate @account
      @show_more            = "#show_more_#{params[:id]}"
      @manage_recording     = "#manage_recording_#{params[:id]}"
     
      
      
      if params[:catalog] != '0'
        @catalog                        = Catalog.cached_find(params[:catalog])
        @remove_recording_from_catalog  = "#remove_recording_#{params[:id]}_from_catalog"
        @manage_recording               = nil
      end
      if params[:add_recordings_to_catalog] != '0'
        @catalog                        = Catalog.cached_find(params[:add_recordings_to_catalog])
        @add_recording_to_catalog       = "#add_recording_#{params[:id]}_to_catalog"
        @manage_recording               = nil

      end
      
      if params[:add_recordings_to_playlist] != '0'
        @playlist                        = Playlist.cached_find(params[:add_recordings_to_playlist])
        #@add_recording_to_playlist       = "#add_recording_#{params[:id]}_to_playlist"
        @manage_recording               = nil
        
        playlist_item = PlaylistItem.where(playlist_id: @playlist.id, playlist_itemable_id: params[:id], playlist_itemable_type: 'Recording').first
        
        if playlist_item
          @remove_recording_from_playlist   = "#remove_recording_#{params[:id]}_from_playlist"
        else
          @add_recording_to_playlist        = "#add_recording_#{params[:id]}_to_playlist"
        end
      end

    else
      if catalog_user   = CatalogUser.cached_where(params[:catalog], current_user.id)
        @shared_catalog_recording     = "#shared_catalog_recording_#{params[:id]}"
        @catalog = catalog_user.catalog
      end
    end
    
    

  end
  
end
