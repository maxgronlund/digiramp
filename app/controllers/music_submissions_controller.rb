class MusicSubmissionsController < ApplicationController
  
  def destroy
    if OpportunityUser.where(user_id: params[:user_id], opportunity_id: params[:opportunity_id]).first
      music_submission  = MusicSubmission.cached_find(params[:id])
      @music_submission_id = music_submission.id
      music_submission.destroy
    end

  end
  
  def update
    @music_submission           =  MusicSubmission.find(params[:id])
    @music_submission.selected  =  params[:music_submission][:selected]
    @music_submission.save!
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_music_request_and_submission
    @music_request    = MusicRequest.cached_find(params[:music_request_id])
    @opportunity      = Opportunity.cached_find(params[:opportunity_id])
  end
  
  
end
