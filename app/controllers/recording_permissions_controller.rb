class RecordingPermissionsController < ApplicationController
  #include CatalogsHelper
  
  def show

    @recording             = Recording.cached_find(params[:id])
    
    @account               = @recording.account     if @recording.account
    @common_work           = @recording.common_work if @recording.common_work

 
    case params[:permissions]
    
    when 'catalog_recordings'
      current_catalog_user  = CatalogUser.where(user_id: current_user.id, catalog_id: params[:permission_id]).first
      @catalog               = Catalog.cached_find(params[:permission_id])
      @read_recording        = "#read_recording_#{params[:id]}"           if current_catalog_user.read_recording
      @update_recording      = "#update_recording_#{params[:id]}"         if current_catalog_user.update_recording
      @delete_recording      = "#delete_recording_#{params[:id]}"         if current_catalog_user.delete_recording
      @show_more             = "#show_more_#{params[:id]}"                if current_catalog_user.read_recording
      @remove_from_catalog   = "#remove_from_catalog_#{params[:id]}"      if current_account_user.update_catalog
    
    when 'catalog_common_work_recordings'
      current_catalog_user   = CatalogUser.where(user_id: current_user.id, catalog_id: params[:permission_id]).first

      @catalog               = Catalog.cached_find(params[:permission_id])
      @read_recording        = "#read_recording_#{params[:id]}"           if current_catalog_user.read_recording
      @update_recording      = "#update_recording_#{params[:id]}"         if current_catalog_user.update_recording
      @delete_recording      = "#delete_recording_#{params[:id]}"         if current_catalog_user.delete_recording
      @show_more             = "#show_more_#{params[:id]}"                if current_catalog_user.read_recording
      
      
    when 'add_recordings'

      current_catalog_user = CatalogUser.where(user_id: current_user.id, catalog_id: params[:permission_id]).first
      @catalog               = Catalog.cached_find(params[:permission_id])
      @read_recording        = "#read_recording_#{params[:id]}"           if current_catalog_user.read_recording

      @show_more             = "#show_more_#{params[:id]}"                if current_catalog_user.read_recording
      @add_to_catalog        = "#add_to_catalog_#{params[:id]}"           if current_account_user.update_catalog

    when 'account_recordings'

         @read_recording        = "#read_shared_recording_#{params[:id]}"    if current_account_user.read_recording
       @update_recording      = "#update_shared_recording_#{params[:id]}"    if current_account_user.update_recording
       @delete_recording      = "#delete_shared_recording_#{params[:id]}"    if current_account_user.delete_recording
         @show_more             = "#show_shared_more_#{params[:id]}"         if current_account_user.read_recording
      
    when 'submission_recordings'

      @music_request          = MusicRequest.cached_find(params[:permission_id])
      @opportunity            = @music_request.opportunity

      unless MusicSubmission.where( music_request_id: @music_request.id, recording_id: params[:id]).first
        @add_to_request        = "#add_to_request_#{params[:id]}"           if true
        @recording_id          = params[:id]
      end
      
    when 'submission'
      
      #ap params
      #@music_request          = MusicRequest.cached_find(params[:permission_id])
      #@opportunity            = @music_request.opportunity
      #
      #unless MusicSubmission.where( music_request_id: @music_request.id, recording_id: params[:id]).first
      #  @add_to_request        = "#add_to_request_#{params[:id]}"           if true
      #  @recording_id          = params[:id]
      #end
      
    when 'no_buttons'
      
      
    else
      
      
    
    end       
    
  
    if params[:add_recordings_to_catalog] != '0'
      @catalog         = Catalog.cached_find(params[:add_recordings_to_catalog])
      @add_to_catalog  = "#add_to_catalog_#{params[:id]}"
    end

  end
  
 
end
