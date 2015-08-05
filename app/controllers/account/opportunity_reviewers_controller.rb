class Account::OpportunityReviewersController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def show
    @opportunity       = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_user  = OpportunityUser.find_by_uuid(params[:id])
    @user              = @opportunity_user.user
  end

  def edit
  end

  def destroy
    if super? || current_account_user.update_opportunity
      redirect_to account_account_opportunity_opportunity_reviewers_path( @account, @opportunity)
    else
      forbidden
    end
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_evaluation_params
    params.require(:opportunity_evaluation).permit(:opportunity_id,
                                                   :user_id,
                                                   :uuid,       
                                                   :email,     
                                                   :emails,
                                                   :subject,      
                                                   :body
                                                  )
                                                 
  end
end


