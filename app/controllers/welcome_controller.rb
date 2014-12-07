class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to user_path current_user
    else
      @recordings =  Recording.public_access.last(4)
      @users      =  User.public_profiles.order('followers_count desc').first(16)
    end
  end
end
