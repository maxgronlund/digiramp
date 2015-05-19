class User::UsersController < ApplicationController
  def show
    begin @user = User.cached_find(params[:id])
      redirect_to user_path( @user )
    rescue
      not_found
    end
  end
  
end
