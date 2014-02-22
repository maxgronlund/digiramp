class PasswordResetsController < ApplicationController

  def new
  end
  
  def create
    email = params[:sessions][:email].to_s
    user = User.find_by_email(email)
    if user
      user.send_password_reset 
      flash[:info] = { title: "Request received", body: "You should receive an email with instructions in a few minutes" }
    else
      flash[:danger] = { title: "Sorry", body: "No user with that email  #{email}  on record" }
    end
    redirect_to :back
  end
  
  def email_send
    
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
    elsif @user.update(user_params)
      flash[:info] = { title: "Success", body: "Your password has been reset" }
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      if @user.current_account
        redirect_to account_path( @user.account) 
      else
        redirect_to root_path
      end
      #redirect_to login_index_path
      
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
