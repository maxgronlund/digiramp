class RecordingPermissionsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    if current_user.can_administrate @account
      @can_manage     = true
    end
  end
  
  def show
    
    
    
    if current_user.can_administrate @account
      @show_more            = "#show_more_#{params[:id]}"
      @manage_recording     = "#manage_recording_#{params[:id]}"
      @recording            = Recording.cached_find(params[:id])
      @common_work          = CommonWork.cached_find(@recording.common_work_id)
      
      
      if params[:catalog] != '0'
        @catalog                        = Catalog.cached_find(params[:catalog])
        @remove_recording_from_catalog  = "#remove_recording_#{params[:id]}_from_catalog"
        @manage_recording               = nil
      end
      if params[:add_recordings_to_catalog] != '0'
        @catalog                        = Catalog.cached_find(params[:add_recordings_to_catalog])
        @add_recording_to_catalog       = "#add_recording_#{params[:id]}_to_catalog"
        @manage_recording               = nil
        #logger.debug '----------------------------------------------------------------'
        #logger.debug @add_recording_to_catalog
        #logger.debug '----------------------------------------------------------------'
      end
      
      
    end
    
    

  end
  
end
