class UserUnlikesController < ApplicationController
  def new
    @user = User.cached_find(params[:user_id])
    if item_like =  ItemLike.find_by(like_id: @user.id, like_type: @user.class.name, user_id: current_user.id)
      item_like.destroy
    end
    @user.update_user_likes
  end
end
