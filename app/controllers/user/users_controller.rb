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
    @user.update_meta
    update_ips
    redirect_to user_user_legal_index_path( @user)
  end
  
  def user_params
    params.require(:user).permit!#( UserParams::PUBLIC_PARAMS ) 
  end
  
  private
  
  def update_ips
    @user.ipis.update_all(full_name: @user.full_name)
  end
  
end
