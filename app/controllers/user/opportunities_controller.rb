class User::OpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index]

  
  def index
    forbidden unless @user.account.read_opportunities
  end

  
end
