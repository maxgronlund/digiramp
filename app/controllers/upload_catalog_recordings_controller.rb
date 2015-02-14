class UploadCatalogRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [:create, :show, :new]
  
  def new
    @recording        = Recording.new
    #@catalog          = Catalog.cached_find(params[:catalog_id])
  end
  
  # called when an  import is completed
  def create

    if @import_batch   = TransloaditParser.parse_recordings( params[:transloadit], @account.id, current_user )
      flash[:info]          = { title: "SUCCESS: ", body: "Import completed" }
      add_to_catalog @import_batch, @catalog.id
      redirect_to account_catalog_upload_catalog_recording_path( @account, @catalog, @import_batch )
    else
      flash[:danger]        = { title: "ERROR: ", body: "Something went wrong" }
      redirect_to     new_account_catalog_upload_catalog_recording_path(@account, @catalog)
    end
  end
  
  def show
    #@catalog              = Catalog.cached_find(params[:catalog_id])
    @import_batch         = ImportBatch.cached_find(params[:id])
  end
  
  def add_to_catalog import_batch, catalog_id
    
    
    import_batch.recordings.each do |recording|
      
      CatalogsRecordings.where(catalog_id: catalog_id, recording_id: recording.id)
                        .first_or_create(catalog_id: catalog_id, recording_id: recording.id)
                        

    end
  end
  
  
end
