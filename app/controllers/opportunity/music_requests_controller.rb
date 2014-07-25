class Opportunity::MusicRequestsController < ApplicationController
  
  include OpportunitiesHelper
  before_filter :access_opportunity
  
  
  def show
    @music_request = MusicRequest.cached_find(params[:id])
    @submissions   = MusicSubmission.where(music_request_id: @music_request.id, user_id: current_user.id)
  end
end
