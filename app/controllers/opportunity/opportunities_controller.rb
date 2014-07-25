class Opportunity::OpportunitiesController < ApplicationController
  def index
  end

  def show
    begin
      @opportunity = Opportunity.cached_find(params[:id])
      @opportunity_user = OpportunityUser.where(opportunity_id: @opportunity.id, user_id: current_user.id)
      forbidden unless @opportunity_user
      @account = current_user.account
    rescue
      not_found
    end
  end
end
