class User::OpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index]

  
  def index
    
  end

  
end
