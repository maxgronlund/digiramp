class ExportImportBatchesController < ApplicationController
  before_filter :there_is_access_to_the_account
  def show
    
    @import_batch = ImportBatch.find(params[:id])
    @recordings   = @import_batch.recordings
    
    
    
    #@works = @account.common_works.order(:title)
    respond_to do |format|
      format.csv { render text: @recordings.to_csv }
    end
  end
  
  
  
  
end
