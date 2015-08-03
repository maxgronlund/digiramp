class MusicSubmissionsController < ApplicationController
  
  def destroy
    @opportunity      = Opportunity.cached_find(params[:opportunity_id])
    
    if  @opportunity.public_opportunity || 
        OpportunityUser.where(user_id: params[:user_id], 
                              opportunity_id: params[:opportunity_id]).first
                              
      music_submission  = MusicSubmission.cached_find(params[:id])
      @music_submission_id = music_submission.id
      music_submission.destroy
    end
    @user = current_user
    #redirect_to_return_url root_path
  end
  
  def update
    #@music_submission           = MusicSubmission.cached_find(params[:id])
    #@account                    = @music_submission.account
    #@music_request              = @music_submission.music_request
    #@opportunity                = @music_request.opportunity
    #ap params
    #if params[:commit] == "Select"
    #  ap 'bam'
    #  MusicSubmissionSelection.where(
    #                                account_id:           @account.id,
    #                                music_submission_id:  @music_submission.id,
    #                                user_id:              @account.user_id
    #                                )
    #                          .first_or_create(
    #                                account_id:           @account.id,
    #                                music_submission_id:  @music_submission.id,
    #                                user_id:              @account.user_id
    #                                )
    #else
    #  if music_submission_selection = MusicSubmissionSelection.find_by(
    #                                account_id:           @account.id,
    #                                music_submission_id:  @music_submission.id,
    #                                user_id:              @account.user_id
    #                                )
    #    music_submission_selection.destroy
    #  end
    #end
    #redirect_to_return_url root_path                               
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_music_request_and_submission
    @music_request    = MusicRequest.cached_find(params[:music_request_id])
    @opportunity      = Opportunity.cached_find(params[:opportunity_id])
  end
  
  private
 
  
end
