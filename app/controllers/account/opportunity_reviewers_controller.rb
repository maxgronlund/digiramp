class Account::OpportunityReviewersController < ApplicationController
  include AccountsHelper
  #before_filter :get_account_account
  before_filter :access_account
  
  def index
    ap params
    if current_account_user.update_opportunity
      @user = current_account_user.user
      @opportunity = Opportunity.find(params[:opportunity_id])
    else
      forbidden
    end
    
  end

  def new
  end

  def edit
  end

  def destroy
  end
end
