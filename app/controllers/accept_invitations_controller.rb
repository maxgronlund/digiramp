class AcceptInvitationsController < ApplicationController

  def edit
    begin
      @user = User.find_by_password_reset_token!(params[:id])
      if current_user && current_user.id == @user.id
        @error = 'you are alreaddy logged in'
        @status = 'logged in'
      elsif @user
        
      else
         @error = 'You are not logged in as the user that received the invitation'
         @status = 'logged in on other account'
      end 
    rescue
      @error = 'This invitation is no longer valid'
    end
        
    
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.weeks.ago
      redirect_to root_path
    elsif @user.update!(user_params)
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      if @user.current_account
        redirect_to edit_user_path( @user ) 
      else
        redirect_to root_path
      end
    else
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit!
  end
end
