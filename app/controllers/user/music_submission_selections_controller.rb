class User::MusicSubmissionSelectionsController < ApplicationController
  
  def create
    ap params
    MusicSubmissionSelection.create(music_submission_selection_params)
    @user               = User.cached_find(params[:user_id])
    @account            = Account.cached_find(params[:account_id])
    @opportunity        = Opportunity.cached_find(params[:opportunity_id])
    @music_submission   = MusicSubmission.cached_find(params[:music_submission_id])
    @music_request      = MusicRequest.cached_find(params[:music_request_id])
  end

  def destroy
    music_submission_selection = MusicSubmissionSelection.cached_find(params[:id])
    @user               = User.cached_find(params[:user_id])
    @account            = Account.cached_find(params[:account_id])
    @opportunity        = Opportunity.cached_find(params[:opportunity_id])
    @music_submission   = MusicSubmission.cached_find(params[:music_submission_id])
    @music_request      = MusicRequest.cached_find(params[:music_request_id])
    @opportunity_user   = music_submission_selection.opportunity_user
    music_submission_selection.destroy
  end
  
  private
  
  def music_submission_selection_params
    params.require(:music_submission_selection).permit(:account_id, 
                                                       :music_request_id, 
                                                       :user_id, 
                                                       :music_submission_id,
                                                       :opportunity_user_id)
  end

end
