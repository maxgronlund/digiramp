class UploadCatalogRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_filter :there_is_access_to_the_account

  def new
    @recording        = Recording.new
    @catalog          = Catalog.cached_find(params[:catalog_id])
  end
  
  # called when an  import is completed
  def create
    @catalog              = Catalog.cached_find(params[:catalog_id])
    @import_batch         = TransloaditParser.parse_recordings( params[:transloadit], @account.id )
    
    
    
    #flash[:info]          = { title: "SUCCESS: ", body: "Import completed" }
    
    #redirect_to account_import_batch_path(@account,   @import_batch)
    add_to_catalog @import_batch, @catalog.id
    
    redirect_to account_catalog_upload_catalog_recording_path( @account, @catalog, @import_batch )
  end
  
  def show
    @catalog              = Catalog.cached_find(params[:catalog_id])
    @import_batch         = ImportBatch.cached_find(params[:id])
  end
  
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
