class Account::SubmitRecordingsController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def index
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    @music_request  = MusicRequest.cached_find(params[:music_request_id])
    @recordings     = @account.recordings -  @music_request.recordings
  end
end
