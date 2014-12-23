class Account::OpportunityReviewersController < ApplicationController
  include AccountsHelper
  #before_filter :get_account_account
  before_filter :access_account
  
  def index
    
    if current_account_user.update_opportunity
      @user = current_account_user.user
      @opportunity = Opportunity.find(params[:opportunity_id])
    else
      forbidden
    end
    
  end

  def new
    if current_account_user.update_opportunity
      @user                   = current_account_user.user
      @opportunity            = Opportunity.find(params[:opportunity_id])
      @opportunity_evaluation = OpportunityEvaluation.new
    else
      forbidden
    end
    
    
  end
  
  def create
    ap params
    
     @opportunity_evaluation = OpportunityEvaluation.create(opportunity_evaluation_params)
     ap @opportunity_evaluation
    redirect_to :back
  end

  def edit
  end

  def destroy
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_evaluation_params
    params.require(:opportunity_evaluation).permit!
  end
end
