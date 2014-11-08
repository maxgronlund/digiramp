class Opportunity::MusicSubmissionsController < ApplicationController
  
  include OpportunitiesHelper
  before_filter :access_opportunity
  
  
  def index
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @user            = current_user
  end

  def show
  end

  def new
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    
    # plain and simple, super users can search all recordings
    if current_user.role == 'Super'
      @recordings   =  Recording.not_in_bucket.search_all( params[:query]).order('title asc').page(params[:page]).per(48)
    else
      account_users =  AccountUser.where(user_id: current_user.id)
    
      # !!! optimize
      recording_ids = []
      account_users.each do |account_user|
        recording_ids   += account_user.account.recording_ids
      end
      @recordings =  Recording.not_in_bucket.search_from_ids(recording_ids, params[:query]).order('title asc').page(params[:page]).per(48)
    end

  end

  def edit
  end
  
  def destroy
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @music_submission  = MusicSubmission.cached_find(params[:id])
    @music_submission.destroy!
    redirect_to opportunity_opportunity_music_request_path(@opportunity, @music_request)
  end
end
