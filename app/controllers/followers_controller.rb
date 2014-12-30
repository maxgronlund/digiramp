class FollowersController < ApplicationController
  before_filter :get_user
  
  
  def index
    #@followers = @user.followers
    if params[:commit] == 'Go'
      @whipe_users = true
      params.delete :commit
      session[:user_query] = params[:query]
    end
    
    session[:user_query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:user_query]
    

    @users = @user.followers.public_profiles.search(params[:query]).page(params[:page]).per(8)
  end
end
