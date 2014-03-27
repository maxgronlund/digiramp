class ExportRecordingsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @recordings = @account.recordings.order(:title)
    respond_to do |format|
      format.csv { render text: @recordings.to_csv }
    end
  end
end
