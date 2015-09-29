class UserLikesController < ApplicationController
  before_action :get_user
  
  
  def index
    if params[:commit] == 'Go'
      @whipe_users = true
      params.delete :commit
      session[:user_query] = params[:query]
    end
    
    session[:user_query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:user_query]
    @users = @user.liked_users.search(params[:query]).page(params[:page]).per(8)
    #user_ids = ItemLike.where(like_type: 'User', user_id: @user.id).pluck(:id)
    #ap user_ids
    #@users = User
    #  .where(id: user_ids)
    #  .public_profiles.search(params[:query])
    #  .order(:id)
    #  .page(params[:page])
    #  .per(8)
    
    #@users = @user.followers.public_profiles.search(params[:query]).page(params[:page]).per(8)
  end
  
  def new
    
    @user = User.cached_find(params[:user_id])
    ItemLike.create(like_id: @user.id, like_type: @user.class.name, user_id: current_user.id)
    @user.update_user_likes
    current_user.update_liked_users_count
  end
  
  #def index
  #  
  #  #if params[:commit] == 'Go'
  #  #  @whipe_users = true
  #  #  params.delete :commit
  #  #  session[:user_query] = params[:query]
  #  #end
  #  #
  #  #session[:user_query] = nil if params[:clear] == 'clear'
  #  #params[:query]  = session[:user_query]
  #  #
  #  #@user = User.cached_find(params[:user_id])
  #  #user_ids = ItemLike.where(like_type: 'User', user_id: @user.id).pluck(:id)
  #  #ap user_ids
  #  #@users = User
  #  #        .public_profiles.search(params[:query])
  #  #        .order(:id)
  #  #        .page(params[:page])
  #  #        .per(8)
  #  #
  #  #
  #  
  #end
end
