class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.search(params[:query]).order('lower(email) ASC').page(params[:page]).per(50)
  end

  def show
    
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      flash[:info] = { title: "SUCCESS: ", body: "User updated" }
    else
      flash[:danger] = { title: "Error", body: "User not updated" }
    end
      redirect_to admin_users_path
  end
  
  def destroy
    @user = User.cached_find(params[:id])
    #AccountUser.where(user_id: @user.id)
    @user.destroy
    redirect_to admin_users_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit!  if current_user.can_edit?
    end
end
