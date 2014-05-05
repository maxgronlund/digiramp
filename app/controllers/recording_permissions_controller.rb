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
    
    # if the current user is the account administrator
    if current_user.can_administrate @account
      
      # current user can open the recording page
      @show_more            = "#show_more_#{params[:id]}"
      
      # curent user can edit recording
      @manage_recording     = "#manage_recording_#{params[:id]}"
     
      
      # if current user is on a catalog
      if params[:catalog] != '0'
        @catalog                        = Catalog.cached_find(params[:catalog])
        
        # current user can add remove recording from catalog
        @remove_recording_from_catalog  = "#remove_recording_#{params[:id]}_from_catalog"
        @manage_recording               = nil
      end
      if params[:add_recordings_to_catalog] != '0'
        
        # current user can remove recording to catalog
        @catalog                        = Catalog.cached_find(params[:add_recordings_to_catalog])
        @add_recording_to_catalog       = "#add_recording_#{params[:id]}_to_catalog"
        @manage_recording               = nil

      end
      
      if params[:add_recordings_to_playlist] != '0'
        # current user can add recording to playlist
        @playlist                        = Playlist.cached_find(params[:add_recordings_to_playlist])
        
        
        @manage_recording                = nil
        
        playlist_item = PlaylistItem.where(playlist_id: @playlist.id, playlist_itemable_id: params[:id], playlist_itemable_type: 'Recording').first
        
        if playlist_item
          @remove_recording_from_playlist   = "#remove_recording_#{params[:id]}_from_playlist"
        else
          @add_recording_to_playlist        = "#add_recording_#{params[:id]}_to_playlist"
        end
      end

    else
      # if current user is a catalog user
      if catalog_user  = CatalogUser.cached_where( params[:catalog], current_user.id)

        # insert the show shared recording button
        @show_shared_recording        = "#show_shared_recording_#{params[:id]}"
        if catalog_user.edit_recordings
          @edit_shared_recording     = "#edit_shared_recording_#{params[:id]}"
        end
        
        @catalog                      = catalog_user.catalog
        @manage_recording                = nil
      elsif
        # check if the recording is a catalog where the user has access
        #catalog_item_ids  
        #catalog_item     =  CatalogItem.where(catalog_itemable_id: @recording.id, catalog_itemable_type: 'Recording').first
        
        logger.debug '----------- not found --------------------------'
        #logger.debug params[:shared_catalogs]
        #
        #CatalogUser.where(user_id: catalog_user.id, catalog_id: params[:id]).first
        #@show_more            = "#show_more_#{params[:id]}"
      end
    end
    
    

  end
  
end
