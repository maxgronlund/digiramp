class User::CollectionsController < ApplicationController
  
  before_filter :access_user, only: [:index]

  
  def index
    
  end

  
end
