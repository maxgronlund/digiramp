class Admin::UsersController < ApplicationController
  
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    forbidden unless can_edit?
    @users = User.search(params[:query]).order('lower(email) ASC').page(params[:page]).per(50)
  end

  def show
    
  end
  
  def edit
    
  end
  
  def update
    forbidden unless can_edit?
    role = @user.role
    if @user.update(user_params)
      flash[:info] = { title: "SUCCESS: ", body: "User updated" }
      update_account_users if role != @user.role
    else
      flash[:danger] = { title: "Error", body: "User not updated" }
    end
      redirect_to admin_users_path
  end
  
  def update_account_users
    @user.account_users.each do |account_user|
      
      if @user.role == 'super'
        # super users has all permissions
        account_user.grand_all_permissions
      else
        # remove super account_user from all accounts
        unless account_user.user.account_id   == account_user.account_id
          if account_user.role == 'Super'
            account_user.account.permitted_user_ids -= [account_user.user_id]
            account_user.destroy!
          end
        end
      end
      
    end
  end
  
  def destroy
    forbidden unless can_edit?
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
