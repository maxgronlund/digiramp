class Account::OpportunityProvidersController < ApplicationController
  
  #before_action :set_opportunity, only: [:show, :edit, :update, :destroy, :music_submissions]
  
  include AccountsHelper
  before_action :access_account
  #before_action :current_user_authorized, only: [:index, :show, :new, :edit]


  
  def index
    forbidden unless current_account_user && current_account_user.update_opportunity
    @opportunity = Opportunity.cached_find(params[:opportunity_id])
    @user        = current_user
    @authorized  = true
  end
end
