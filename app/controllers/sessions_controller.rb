class SessionsController < ApplicationController
  
  def new
    
  end

  
  def create
    
    user = User.where(email: params[:sessions][:email]).first


    if user && user.authenticate(params[:sessions][:password])
      flash[:info] = { title: "Success", body: "You are logged in" }
      
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token  
      end
      
      
      redirect_to account_path(user.current_account_id)

    else
      #, notice: "Email or password is invalid! If you don't have an account? Please contact us"
      #redirect_to login_index_path
      flash[:danger] = { title: "Error", body: "You are not logged in" }
      
      redirect_to root_path
    end
  end

  def destroy
    #session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end
  
end