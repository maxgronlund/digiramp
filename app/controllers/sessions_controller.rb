class SessionsController < ApplicationController
  
  def new
    
  end

  
  def create
    
    user = User.where(email: params[:sessions][:email]).first


    if user && user.authenticate(params[:sessions][:password])
      flash[:info] = { title: "SUCCESS: ", body: "You are logged in" }
      
      
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token  
      end
      
      if current_user && current_user.super?
        session[:user_id] = current_user.id
        redirect_to admin_index_path
      else
        account = Account.cached_find(user.account_id)
        logger.debug '***************************************************************'
        logger.debug account.inspect
        logger.debug '***************************************************************'
        account.visits += 1
        account.save!
        redirect_to account_path(account)
      end

    else
      #, notice: "Email or password is invalid! If you don't have an account? Please contact us"
      #redirect_to login_index_path
      flash[:danger] = { title: "Error", body: "You are not logged in" }
      
      redirect_to root_path
    end
  end

  def destroy
    #session[:user_id] = nil
    begin 
      user = User.cached_find_by_auth_token( cookies[:auth_token] )
      user.flush_auth_token_cache(cookies[:auth_token])
    rescue
    end
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_url, notice: "Logged out!"
  end
  
end