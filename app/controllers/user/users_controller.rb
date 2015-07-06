class User::UsersController < ApplicationController
  
  
  def show
    begin @user = User.cached_find(params[:id])
      redirect_to user_path( @user )
    rescue
      not_found
    end
  end
  
  def update
    @user = User.cached_find(params[:id])
    @user.update(user_params)
    redirect_to user_user_legal_index_path( @user)
  end
  
  def user_params
    params.require(:user).permit( UserParams::PUBLIC_PARAMS ) 
  end
  
end
