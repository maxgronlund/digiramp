class PasswordResetsController < ApplicationController

  def new
  end
  
  def create
    email = params[:sessions][:email].to_s
    
    user = User.find_by_email(email.downcase)
    
    if user
      user.send_password_reset 
      flash[:info]   = "You should receive an email with instructions in a few moments" 
    else
      flash[:danger] = "No user with that email  #{email}  on record" 
    end
    redirect_to :back
  end
  
  def email_send
    
  end

  def edit
    ap params
    begin
      @reset_user = User.find_by_password_reset_token!(params[:id])
    rescue
    end
    forbidden unless @reset_user
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
        
    elsif params[:user][:password].to_s == ''
      flash[:danger] = "Password can't be blank" 
      redirect_to edit_password_reset_path(params[:id])
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:danger] = "Password and Password Confirmation mismatch" 
      redirect_to edit_password_reset_path(params[:id])
    elsif @user.update(user_params)
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      if @user.current_account
        redirect_to user_path( @user) 
      else
        redirect_to root_path
      end
      #redirect_to login_index_path
      
    else
      redirect_to edit_password_reset_path(params[:id])
    end
  end
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
end
