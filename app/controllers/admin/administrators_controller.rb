class Admin::AdministratorsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, except: [:destroy]
  
  def index
    @admins = User.supers
  end
  
  def edit
     @user = User.cached_find(params[:id])
  end

  def update
    @user = User.cached_find(params[:id])
    if @user.update(administrators_params)

    else
      flash[:danger] =  "User not updated" 
    end
      redirect_to admin_administrators_path
  end
  
  def destroy
    @user = User.cached_find(params[:id])
    @user.destroy
    redirect_to admin_administrators_path
  end
  
private
  def set_user
    @user = User.cached_find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def administrators_params
    params.require(:user).permit!  if current_user.can_edit?
  end
end
