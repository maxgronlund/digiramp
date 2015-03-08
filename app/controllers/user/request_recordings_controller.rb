class User::RequestRecordingsController < ApplicationController
  
  
  def index

    get_private_user
    @recordings = []
    begin
      @opportunity          = Opportunity.cached_find(params[:opportunity_id])
      @music_request        = MusicRequest.cached_find(params[:music_request_id])
      user_recording_ids    = @user.recording_ids
      music_submission_ids  = MusicSubmission.where(id: @music_request.music_submission_ids).pluck(:recording_id)
      recording_ids         = user_recording_ids - music_submission_ids
      if params[:query]
        #@remove_old_recordings = true
        recordings            = Recording.where(id: recording_ids)
        @recordings           = Recording.recordings_search(recordings, params[:query]).order('uniq_title asc').page(params[:page]).per(4)
      else
        @recordings           = Recording.where(id: recording_ids).order('uniq_title asc').page(params[:page]).per(4)
      end
    rescue
      
    end

  end
  
  def update
    
  end
  
  def create
    
  end
 
  
  
end
