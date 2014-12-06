class User::OpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index]

  
  def index
    @authorized     = true if current_user.id = @user.id
    @opportunities  = @user.opportunities.order('deadline desc')
  end

  
end


#- opportunity_link = @user.account_id == opportunity.account_id ? account_account_opportunity_path(@user.account, opportunity)  : opportunity_opportunity_path(opportunity)