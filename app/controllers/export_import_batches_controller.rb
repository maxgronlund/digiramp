class ExportImportBatchesController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  def show
    @import_batch = ImportBatch.find(params[:id])
    @recordings   = @import_batch.recordings
    respond_to do |format|
      format.csv { render text: @recordings.to_csv }
    end
  end
end
