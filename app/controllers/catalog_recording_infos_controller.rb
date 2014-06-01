class CatalogRecordingInfosController < ApplicationController
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_to_account, only: [:show, :destroy]
  before_filter :access_catalog, only: [:show, :destroy]
  #before_filter :there_is_access_to_catalog
  
  
  
  
  def show
    forbidden unless current_catalog_user.read_recording
    @recording = Recording.cached_find(params[:id])
  
  end
  
  def destroy
    forbidden unless current_catalog_user.delete_recording
    @recording = Recording.cached_find(params[:id])
    @recording.destroy
    
    redirect_to account_catalog_catalog_recordings_path(@account, @catalog)
  end
  
  
  

end
