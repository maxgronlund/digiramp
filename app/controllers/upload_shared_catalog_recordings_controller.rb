class UploadSharedCatalogRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_action :access_user

  def new
    @catalog_user      = CatalogUser.where(user_id: @user.id, catalog_id: params[:shared_catalog_id]).first
    @catalog           = @catalog_user.catalog
    
    if @catalog_user.create_recordings && @catalog_user
      
      @recording         = Recording.new
    else
      forbidden
    end
  end
  
  
  # called when an  import is completed
  def create
    # get the catalog
    @catalog      = Catalog.cached_find(params[:shared_catalog_id])
    @catalog_user = CatalogUser.cached_where(@catalog.id, @user.id)
    
    if @catalog_user.create_recordings && @catalog_user
      
      # parse the hash returned from www.transloadit.com
      # and add the recordings to the catalog owners account
      @import_batch         = TransloaditParser.parse_recordings( params[:transloadit], @catalog.account.id, current_user )
      
      # add to the catalog
      add_to_catalog @import_batch, @catalog.id

      # post message
      flash[:info]          =  "Import completed" 
      
      # bounce back to the shared catalog
      redirect_to user_shared_catalog_upload_shared_catalog_recording_path(@user, @catalog,  @import_batch)
    else
      forbidden
    end
    
  end
  
  def show
    @catalog              = Catalog.cached_find(params[:shared_catalog_id])
    @import_batch         = ImportBatch.cached_find(params[:id])
  end
  #
  def add_to_catalog import_batch, catalog_id
    
    
    import_batch.recordings.each do |recording|
      CatalogsRecordings.where(catalog_id: catalog_id, recording_id: recording.id)
                        .first_or_create(catalog_id: catalog_id, recording_id: recording.id)

    end
  end
  
  
end
