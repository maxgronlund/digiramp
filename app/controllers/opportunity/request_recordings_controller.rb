class Opportunity::RequestRecordingsController < ApplicationController
  
  #include OpportunitiesHelper
  #before_action :access_opportunity
  
  def index
    #if current_user
    #  @opportunity                           = Opportunity.cached_find(params[:opportunity_id])
    #  @music_request                         = MusicRequest.cached_find(params[:music_request_id])
    #  @user                                  = current_user
    #  #not_found unless @opportunity         = Opportunity.cached_find(params[:id])
    #  #not_found unless @user                = User.cached_find(params[:user_id])
    #  #not_found unless @opportunity_user    = current_opportunity_user
    #  
    #  user_recording_ids    = @user.recording_ids
    #  music_submission_ids  = MusicSubmission.where(id: @music_request.music_submission_ids).pluck(:recording_id)
    #  recording_ids         = user_recording_ids - music_submission_ids
    #  if params[:query]
    #    recordings            = Recording.where(id: recording_ids)
    #    @recordings           = Recording.recordings_search(recordings, params[:query]).order('uniq_title asc').page(params[:page]).per(4)
    #  else
    #    @recordings           = Recording.where(id: recording_ids).order('uniq_title asc').page(params[:page]).per(4)
    #  end
    #else
    #  forbidden
    #end
    not_found
  end
  
  def update
    
  end
  
  def create
    
  end
 
  
  
end
