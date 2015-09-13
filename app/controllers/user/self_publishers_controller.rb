class User::SelfPublishersController < ApplicationController
  before_action :access_user
  
  def edit
    @publisher = @user.publishing
  end
  
  def update
    
  end
  
  def show
  end
end
