class UploadSharedCatalogRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_filter :access_user

  def new
    @catalog_user      = CatalogUser.where(user_id: @user.id, catalog_id: params[:shared_catalog_id]).first
    
    if @catalog_user.upload_recordings
      @catalog           = @catalog_user.catalog
      @recording         = Recording.new
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
  
  
  # called when an  import is completed
  def create
    
    #redirect_to :back
    @catalog              = Catalog.cached_find(params[:shared_catalog_id])
    @import_batch         = TransloaditParser.parse_recordings( params[:transloadit], @catalog.account.id )
    add_to_catalog @import_batch, @catalog.id
    
    
    
    flash[:info]          = { title: "SUCCESS: ", body: "Import completed" }
    redirect_to user_shared_catalog_upload_shared_catalog_recording_path(@user, @catalog,  @import_batch)
    #users/115/shared_catalogs/45/upload_shared_catalog_recordings

    #redirect_to :back
  end
  
  def show
    @catalog              = Catalog.cached_find(params[:shared_catalog_id])
    @import_batch         = ImportBatch.cached_find(params[:id])
  end
  #
  def add_to_catalog import_batch, catalog_id
    
    
    import_batch.recordings.each do |recording|
      CatalogItem.create(
                          catalog_id: catalog_id, 
                          catalog_itemable_id: recording.id, 
                          catalog_itemable_type: recording.class.name
                        )
    end
  end
  
  
end
