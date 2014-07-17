class RecordingPermissionsController < ApplicationController
  #include CatalogsHelper
  
  def show
    @recording             = Recording.cached_find(params[:id])
    @account               = @recording.account
    @common_work           = @recording.common_work
    logger.debug '-------------------------------------------------------------------'
    logger.debug params[:permissions]
    
    
 
    case params[:permissions]
    
    when 'catalog_recordings'
      #puts params[:permission_id]
      current_catalog_user  = CatalogUser.where(user_id: current_user.id, catalog_id: params[:permission_id]).first
      #puts current_catalog_user.read_recording ? 'true' : 'false'
      @catalog               = Catalog.cached_find(params[:permission_id])
      @read_recording        = "#read_recording_#{params[:id]}"           if current_catalog_user.read_recording
      @update_recording      = "#update_recording_#{params[:id]}"         if current_catalog_user.update_recording
      @delete_recording      = "#delete_recording_#{params[:id]}"         if current_catalog_user.delete_recording
      @show_more             = "#show_more_#{params[:id]}"                if current_catalog_user.read_recording
      @remove_from_catalog   = "#remove_from_catalog_#{params[:id]}"      if current_account_user.update_catalog
    
    when 'catalog_common_work_recordings'
      current_catalog_user  = CatalogUser.where(user_id: current_user.id, catalog_id: params[:permission_id]).first
      #puts current_catalog_user.read_recording ? 'true' : 'false'
      @catalog               = Catalog.cached_find(params[:permission_id])
      @read_recording        = "#read_recording_#{params[:id]}"           if current_catalog_user.read_recording
      @update_recording      = "#update_recording_#{params[:id]}"         if current_catalog_user.update_recording
      @delete_recording      = "#delete_recording_#{params[:id]}"         if current_catalog_user.delete_recording
      @show_more             = "#show_more_#{params[:id]}"                if current_catalog_user.read_recording
      
      
    when 'add_recordings'
      #puts params[:permission_id]
      #puts '-------------------catalog_recordings------------'
      current_catalog_user = CatalogUser.where(user_id: current_user.id, catalog_id: params[:permission_id]).first
      #puts current_catalog_user.read_recording ? 'true' : 'false'
      @catalog               = Catalog.cached_find(params[:permission_id])
      @read_recording        = "#read_recording_#{params[:id]}"           if current_catalog_user.read_recording
      #@update_recording      = "#update_recording_#{params[:id]}"         if current_catalog_user.update_recording
      #@delete_recording      = "#delete_recording_#{params[:id]}"         if current_catalog_user.delete_recording
      @show_more             = "#show_more_#{params[:id]}"                if current_catalog_user.read_recording
      @add_to_catalog        = "#add_to_catalog_#{params[:id]}"           if current_account_user.update_catalog
    
    #when 'shared_recordings'
    #  puts params[:id]
    #  @user_id = params[:permission_id]
    #  @read_shared_recording        = "#read_shared_recording_#{params[:id]}"    if @recording.read_recording_ids.include?   current_user.id
    #  @update_shared_recording      = "#update_shared_recording_#{params[:id]}"  if @recording.update_recording_ids.include? current_user.id
    #  @delete_shared_recording      = "#delete_shared_recording_#{params[:id]}"  if @recording.delete_recording_ids.include? current_user.id
    #  @show_shared_more             = "#show_shared_more_#{params[:id]}"         if @recording.read_recording_ids.include?   current_user.id
      
    when 'account_recordings'
      #puts '-------------------account_recordings------------'
         @read_recording        = "#read_shared_recording_#{params[:id]}"    if current_account_user.read_recording
       @update_recording      = "#update_shared_recording_#{params[:id]}"    if current_account_user.update_recording
       @delete_recording      = "#delete_shared_recording_#{params[:id]}"    if current_account_user.delete_recording
         @show_more             = "#show_shared_more_#{params[:id]}"         if current_account_user.read_recording
      
    when 'submission_recordings'
      puts '-------------------submission_recordings------------'
      ap params
      #@read_recording        = "#read_shared_recording_#{params[:id]}"    if current_account_user.read_recording
      #@update_recording      = "#update_shared_recording_#{params[:id]}"    if current_account_user.update_recording
      #@delete_recording      = "#delete_shared_recording_#{params[:id]}"    if current_account_user.delete_recording
      #@show_more             = "#show_shared_more_#{params[:id]}"         if current_account_user.read_recording
      @music_request = MusicRequest.cached_find(params[:permission_id])
      @opportunity  = @music_request.opportunity
      #@music_request
      
      @add_to_request        = "#add_to_request_#{params[:id]}"           if true
      @recording_id          = params[:id]
    else
    
    end       
    
    #@read_recording        = "#read_recording_#{params[:id]}"    if @recording.read_recording_ids.include?   current_user.id
    #@update_recording      = "#update_recording_#{params[:id]}"  if @recording.update_recording_ids.include? current_user.id
    #@delete_recording      = "#delete_recording_#{params[:id]}"  if @recording.delete_recording_ids.include? current_user.id
    #@show_more             = "#show_more_#{params[:id]}"         if @recording.show_more_for current_user.id
    
    
    #if @shared_catalog     = params[:shared_catalog] == 'true'
    #  @remove_from_catalog = "#remove_from_catalog_#{params[:id]}"
    #end
    #
    
    
    
    
    #if  params[:catalog] != '0'
    #  # We are in a catalog
    #  @catalog              = Catalog.cached_find(params[:catalog])
    #  @remove_from_catalog  = "#remove_from_catalog_#{params[:id]}"
    if params[:add_recordings_to_catalog] != '0'
      @catalog         = Catalog.cached_find(params[:add_recordings_to_catalog])
      @add_to_catalog  = "#add_to_catalog_#{params[:id]}"
    end

  end
  
  #def show
  #  @recording            = Recording.cached_find(params[:id])
  #  @account              = @recording.account
  #  @common_work          = CommonWork.cached_find(@recording.common_work_id)
  #  
  #  # if the current user is the account administrator
  #  if current_user.can_administrate @account
  #    
  #    # current user can open the recording page
  #    @show_more            = "#show_more_#{params[:id]}"
  #    
  #    # curent user can edit recording
  #    @manage_recording     = "#manage_recording_#{params[:id]}"
  #   
  #    
  #    # if current user is on a catalog
  #    if params[:catalog] != '0'
  #      @catalog                        = Catalog.cached_find(params[:catalog])
  #      
  #      # current user can add remove recording from catalog
  #      @remove_recording_from_catalog  = "#remove_recording_#{params[:id]}_from_catalog"
  #      @manage_recording               = nil
  #    end
  #    if params[:add_recordings_to_catalog] != '0'
  #      
  #      # current user can remove recording to catalog
  #      @catalog                        = Catalog.cached_find(params[:add_recordings_to_catalog])
  #      @add_recording_to_catalog       = "#add_recording_#{params[:id]}_to_catalog"
  #      @manage_recording               = nil
  #
  #    end
  #    
  #    if params[:add_recordings_to_playlist] != '0'
  #      # current user can add recording to playlist
  #      @playlist                        = Playlist.cached_find(params[:add_recordings_to_playlist])
  #      
  #      
  #      @manage_recording                = nil
  #      
  #      playlist_item = PlaylistItem.where(playlist_id: @playlist.id, playlist_itemable_id: params[:id], playlist_itemable_type: 'Recording').first
  #      
  #      if playlist_item
  #        @remove_recording_from_playlist   = "#remove_recording_#{params[:id]}_from_playlist"
  #      else
  #        @add_recording_to_playlist        = "#add_recording_#{params[:id]}_to_playlist"
  #      end
  #    end
  #
  #  else
  #    # if current user is a catalog user
  #    if catalog_user  = CatalogUser.cached_where( params[:catalog], current_user.id)
  #
  #      # insert the show shared recording button
  #      @show_shared_recording        = "#show_shared_recording_#{params[:id]}"
  #      if catalog_user.edit_recordings
  #        @edit_shared_recording     = "#edit_shared_recording_#{params[:id]}"
  #      end
  #      
  #      @catalog                      = catalog_user.catalog
  #      @manage_recording                = nil
  #    elsif
  #      # check if the recording is a catalog where the user has access
  #      #catalog_item_ids  
  #      #catalog_item     =  CatalogItem.where(catalog_itemable_id: @recording.id, catalog_itemable_type: 'Recording').first
  #      
  #      logger.debug '----------- not found --------------------------'
  #      #logger.debug params[:shared_catalogs]
  #      #
  #      #CatalogUser.where(user_id: catalog_user.id, catalog_id: params[:id]).first
  #      #@show_more            = "#show_more_#{params[:id]}"
  #    end
  #  end
  #  
  #  
  #
  #end
  
end
