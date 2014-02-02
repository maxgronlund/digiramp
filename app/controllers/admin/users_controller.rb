class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #layout 'admin'
  


  def index
    @users = User.order('lower(email) ASC').page(params[:page]).per(14)
  end

  def show
    
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      flash[:info] = { title: "Success", body: "User updated" }
    else
      flash[:danger] = { title: "Error", body: "User not updated" }
    end
      redirect_to admin_users_path
  end
  
  def destroy
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit!
    end
end
