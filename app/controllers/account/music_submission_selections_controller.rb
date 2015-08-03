class Account::MusicSubmissionSelectionsController < ApplicationController
  def create
    MusicSubmissionSelection.create(music_submission_selection_params)
    @account            = Account.cached_find(params[:account_id])
    @opportunity        = Opportunity.cached_find(params[:opportunity_id])
    @music_submission   = MusicSubmission.cached_find(params[:music_submission_id])
    @music_request      = MusicRequest.cached_find(params[:music_request_id])
  end

  def destroy
    music_submission_selection = MusicSubmissionSelection.cached_find(params[:id])
    @account            = Account.cached_find(params[:account_id])
    @opportunity        = Opportunity.cached_find(params[:opportunity_id])
    @music_submission   = MusicSubmission.cached_find(params[:music_submission_id])
    @music_request      = MusicRequest.cached_find(params[:music_request_id])
    music_submission_selection.destroy
  end
  
  private
  
  def music_submission_selection_params
    params.require(:music_submission_selection).permit(:account_id, 
                                                       :music_request_id, 
                                                       :user_id, 
                                                       :music_submission_id)
  end

end
