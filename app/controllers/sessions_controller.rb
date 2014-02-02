class SessionsController < ApplicationController
  
  def new
    
  end

  
  def create
    
    user = User.where(email: params[:sessions][:email]).first
    logger.debug '----------------------------------------------------------------'
    logger.debug user.inspect
    logger.debug '----------------------------------------------------------------'

    if user && user.authenticate(params[:password])
      flash[:info] = { title: "Success", body: "You are logged in" }
      #MessageWorker.perform_in 2.seconds, "Logged in!"
      
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token  
      end
      
      #redirect_to user_path( user)
      redirect_to root_path

    else
      #, notice: "Email or password is invalid! If you don't have an account? Please contact us"
      #redirect_to login_index_path
      flash[:danger] = { title: "Error", body: "You are not logged in" }
      destroy
      #redirect_to root_path
    end
  end

  def destroy
    #session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end
  
end