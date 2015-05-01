class FollowingController < ApplicationController
  before_action :get_user
  
  def index
    if params[:commit] == 'Go'
      @whipe_users = true
      params.delete :commit
      session[:user_query] = params[:query]
    end
    
    session[:user_query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:user_query]
    

    @users = @user.followed_users.public_profiles.search(params[:query]).page(params[:page]).per(8)
    
  end
end
