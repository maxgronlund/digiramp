class ImportBatchesController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def index
    @import_batches = @account.import_batches
    @can_edit = true
  end

  def show
    @import_batch = ImportBatch.find(params[:id])
    @recordings   = @import_batch.recordings
    @can_edit = true
  end
  
  def destroy
    @import_batch = ImportBatch.find(params[:id])
    @import_batch.destroy
    redirect_to account_import_batches_path(@account)
  end
  
  def edit
    @import_batch = ImportBatch.find(params[:id])
  end
  
  def update
    @import_batch = ImportBatch.find(params[:id])
    @import_batch.update_attributes(import_batch_params)
    
    if params[:import_batch][:csv_file]
      Recording.import_csv(@import_batch.csv_file)
    end
    
    redirect_to account_import_batch_path(@account, @import_batch)
  end
private
  def import_batch_params
    params.require(:import_batch).permit!
  end
end
