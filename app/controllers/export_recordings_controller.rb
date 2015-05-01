class ExportRecordingsController < ApplicationController
  include AccountsHelper
  before_action :access_account
  def index
    @recordings = @account.recordings.order(:title)
    respond_to do |format|
      format.csv { render text: @recordings.to_csv }
    end
  end
end
