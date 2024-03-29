class Opportunity::MusicSubmissionsController < ApplicationController
  
  include OpportunitiesHelper
  before_action :access_opportunity
  
  
  def index
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @user            = current_user
  end

  def show
    
  end

  # a user can submitt from all accounts where he is granded access?
  def new
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    opportunity      = @music_request.opportunity
    account_id       = opportunity.account_id
    
    submitted_recording_ids = MusicSubmission.where(music_request_id: @music_request.id).pluck(:recording_id)
    
    
    # plain and simple, super users can search all recordings
    #if current_user.role == 'Super'
    #  @recordings   =  Recording.not_in_bucket.search_all( params[:query]).order('title asc').page(params[:page]).per(48)
    #else
    account_users =  AccountUser.where(user_id: current_user.id)
    
    
    opportunity   =  @music_request.opportunity
    account_id    =  opportunity.account_id
    
    if account_id == current_user.account.id
      recording_ids = []
      account_users.each do |account_user|
        recording_ids   += account_user.account.recording_ids
      end
      recording_ids   -= submitted_recording_ids
    else  
      # remove recordings not submitted by current user
      
      current_users_submissions_recording_ids = MusicSubmission.where(user_id: current_user.id, music_request_id: @music_request.id).pluck(:recording_id)
      recording_ids = current_users_submissions_recording_ids
    end
    #
    @recordings =  Recording.not_in_bucket.search_from_ids(recording_ids, params[:query]).order('title asc').page(params[:page]).per(48)
    #end
    @user = current_user
  end

  def edit
  end
  
  def destroy
    @music_request      = MusicRequest.cached_find(params[:music_request_id])
    @music_submission   = MusicSubmission.cached_find(params[:id])
    @music_submission.destroy!
    redirect_to opportunity_opportunity_music_request_path(@opportunity, @music_request)
  end
end
