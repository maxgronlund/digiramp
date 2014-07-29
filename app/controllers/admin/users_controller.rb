class Admin::UsersController < ApplicationController
  
  include UsersHelper
  before_filter :admin_only
  
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
    old_role  = @user.role
    
    if @user.update(user_params)
      flash[:info] = { title: "SUCCESS: ", body: "User updated" }
    else
      flash[:danger] = { title: "Error", body: "User not updated" }
    end
      redirect_to admin_users_path
  end
  
  # this function is expencieve when the user 
  # change role from and to 'SuperUser'
  # move it to worker
  #def update_account_users
  #  if @user.super?
  #    # time to create an account_user for all accounts
  #    Account.all.each do |account|
  #      account_user = AccountUser.where(user_id: @user.id, account_id: account.id)
  #                                .first_or_create(user_id: @user.id, account_id: account.id)
  #      # secure the account_user is 'Super User'                          
  #      account_user.update_super 'upgrade'
  #    end
  #  else
  #    @user.account_users.each do |account_user|
  #      # remove 'Super Users' from account
  #      account_users.update_super 'downgrade'
  #    end
  #  end
  #end
  
  def destroy
    forbidden unless can_edit?
    @user = User.cached_find(params[:id])
    #@user.account.destroy!
    @user.destroy!
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
