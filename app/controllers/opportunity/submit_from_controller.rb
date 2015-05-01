class Opportunity::SubmitFromController < ApplicationController
  
  include OpportunitiesHelper
  before_action :access_opportunity
  
  def index
    
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @user            = current_user
    @authorized      = true
  end
end
