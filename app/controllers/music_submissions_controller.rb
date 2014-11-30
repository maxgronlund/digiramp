class MusicSubmissionsController < ApplicationController
  
  def destroy

   
    # check for the right to delete
    if OpportunityUser.where(user_id: params[:user_id], opportunity_id: params[:opportunity_id]).first
      music_submission  = MusicSubmission.cached_find(params[:id])
      @music_submission_id = music_submission.id
      music_submission.destroy
    end
    #ap @opportunity
    #@music_submission.destroy!
    #redirect_to account_account_opportunity_music_request_path(@account, @opportunity, @music_request)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_music_request_and_submission
    @music_request    = MusicRequest.cached_find(params[:music_request_id])
    @opportunity      = Opportunity.cached_find(params[:opportunity_id])
  end
  
  
end



#{
#    "opportunity_id" => "37",
#           "user_id" => "234",
#            "action" => "destroy",
#        "controller" => "music_submissions",
#                "id" => "119"
#}
#
