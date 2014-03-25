class ImportBatchesController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    @import_batches = @account.import_batches
    @can_edit = true
  end

  def show
    @import_batch = ImportBatch.find(params[:id])
    @recordings  = @import_batch.recordings
    @can_edit = true
  end
  
  def destroy
    @import_batch = ImportBatch.find(params[:id])
    @import_batch.destroy
    redirect_to account_import_batches_path(@account)
  end
end
