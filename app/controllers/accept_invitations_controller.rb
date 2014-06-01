class AcceptInvitationsController < ApplicationController

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.weeks.ago
      redirect_to root_path
    elsif @user.update!(user_params)
      flash[:info] = { title: "SUCCESS: ", body: "Your account has been activated, please take you time and fill in some basic informations" }
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      if @user.current_account
        redirect_to edit_user_account_path( @user, @user.account) 
      else
        redirect_to root_path
      end
    else
      render :edit
    end
  end
  
  def user_params
    #if can_edit?
      params.require(:user).permit!
    #end
  end
end
