class UserLikesController < ApplicationController
  def new
    @user = User.cached_find(params[:user_id])
    ItemLike.create(like_id: @user.id, like_type: @user.class.name, user_id: current_user.id)
    @user.update_user_likes
  end
end
