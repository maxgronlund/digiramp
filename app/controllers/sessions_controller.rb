class SessionsController < ApplicationController

  
  def create
    #redirect_to user_path(current_user)
    #go_to = session[:landing_page] || user_path(current_user)
    puts '-----------------------------------'
    puts session[:landing_page]
    puts '------------------------------------'
    
    
    params[:sessions][:email]  = params[:sessions][:email].downcase
    
    user = User.where(email: params[:sessions][:email]).first

    
    if user && user.authenticate(params[:sessions][:password])
      flash[:info] = { title: "SUCCESS: ", body: "You are logged in" }
      
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token  
      end
      
      if current_user
        session[:user_id] = current_user.id
        session[:account_id] = user.account_id
        
        account           = Account.cached_find(user.account_id)
        account.visits += 1
        account.save!
        
        user.create_activity(  :signed_in, 
                           owner: current_user,
                       recipient: current_user,
                  recipient_type: current_user.class.name,
                      account_id: user.account_id)
                              
                              
        
        go_to = session[:landing_page]
        session[:landing_page] = nil
        redirect_to go_to|| user_path(current_user)
      end

    else
      #, notice: "Email or password is invalid! If you don't have an account? Please contact us"
      #redirect_to login_index_path
      flash[:danger] = { title: "Error", body: "You are not logged in" }
      
      redirect_to login_new_path
    end
  end

  def destroy
    #session[:user_id] = nil
    begin 
      user = User.cached_find_by_auth_token( cookies[:auth_token] )
      user.flush_auth_token_cache(cookies[:auth_token])
      
      user.create_activity(  :logged_out, 
                         owner: user,
                     recipient: user,
                recipient_type: user.class.name,
                    account_id: user.account_id) 
                
                
    rescue
    end
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_url, notice: "Logged out!"
  end
  
end