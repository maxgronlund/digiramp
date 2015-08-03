class User::OpportunitySelectionsController < ApplicationController
  before_action :access_user
  
  def show
    @account = @user.account
    @opportunity = Opportunity.cached_find(params[:id])
    @music_submission_selections = MusicSubmissionSelection.where( opportunity_id: @opportunity.id,
                                                                   account_id:     @user.account.id,
                                                                   user_id:        @user.id)
    
    
  end
end
