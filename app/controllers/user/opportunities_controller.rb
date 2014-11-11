class User::OpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index]

  
  def index
    @authorized = true if current_user.id = @user.id
  end

  
end
