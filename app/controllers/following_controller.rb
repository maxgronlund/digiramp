class FollowingController < ApplicationController
  before_filter :get_user
  
  def index
    @followed_users = @user.followed_users
  end
end
