class Account::InviteProvidersController < ApplicationController
  
  include AccountsHelper
  before_filter :access_account
  
  
  def index
    @opportunity = Opportunity.cached_find(params[:opportunity_id])
  end
end
