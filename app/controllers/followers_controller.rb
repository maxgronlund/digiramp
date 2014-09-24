class FollowersController < ApplicationController
  before_filter :get_user
  
  def index
    @followers = @user.followers
  end
end
