class User::CollectionsController < ApplicationController
  
  before_action :access_user, only: [:index]

  
  def index
    @authorized = true
  end

  
end
