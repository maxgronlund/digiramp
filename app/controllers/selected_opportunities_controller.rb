class SelectedOpportunitiesController < ApplicationController
  def show
    
    if @opportunity_invitation = OpportunityEvaluation.where(uuid: params[:id]).first
      @opportunity = @opportunity_invitation.opportunity
      @account    = @opportunity.account
      @user       = @account.user
    else
      not_found
    end
  end
end
