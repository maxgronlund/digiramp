class SessionsController < ApplicationController

  
  def create
    #ap env['omniauth.auth']
    session[:show_profile_completeness] = true
    
    if current_user
      # the user is all readdy logged in so attach a provider to an existing account
      unless Omniauth.attach_provider( env, current_user )
        flash[:info] = { title: "Notice: ", body: "Provider already attached to account" }
      else
        flash[:info] = { title: "SUCCESS: ", body: "#{env['omniauth.auth'][:provider].upcase} is linked to your account" }
      end
      redirect_to user_user_authorization_providers_path(current_user)
    elsif env['omniauth.auth']
      user = Omniauth.authorize_with_omniauth( env['omniauth.auth'] )
      if user[:user]
        #flash[:info] = { title: "SUCCESS: ", body: user[:message] }
        initialize_session_for user[:user]
        # redirect to a welcome / take the tour screen
      else
        flash[:danger] = { title: "Sorry", body: user[:message]}
        redirect_to login_new_path
      end
      
    else
      params[:sessions][:email]  = params[:sessions][:email].downcase
      user = User.where(email: params[:sessions][:email]).first
      
      if user && user.authenticate(params[:sessions][:password])
      
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token]          = user.auth_token  
        end
        initialize_session_for user
      else
        # Please trye againg
        flash[:danger] = { title: "Sorry", body: "No user we can't authorize found.
                                                  If you have signed up directly on DigiRAMP we can resend you password.
                                                  Otherwize make sure you are signed in with you authorization provider" }
        redirect_to login_new_path
      end
    end
  end
  

  def destroy
    session[:show_profile_completeness] = nil
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
    
    if params[:opportunity_id]
      redirect_to :back
    elsif params[:opportunity_invitation]
      redirect_to login_new_path(params)
      flash[:info] = { title: "Ok", body: "Please login as the user invited to the opportunity" }
    else
      redirect_to root_url, notice: "Logged out!"
    end
  end
  
private
  
  def initialize_session_for user
    #ap env['omniauth.auth']
    #credentials =  env['omniauth.auth']["credentials"]
    #puts 'token'
    #ap credentials['token']
    #puts 'secret'
    #ap credentials['secret']
    #puts 'expires'
    #ap credentials["expires_at"]
    #ap credentials["expires"]
    if env['omniauth.auth']
      if credentials                =  env['omniauth.auth']["credentials"]
        if provider                 = user.authorization_providers.where(provider: env['omniauth.auth']['provider']).first
          provider.oauth_token      = credentials['token']        if credentials['token']
          provider.oauth_expires_at = credentials['expires_at']   if credentials['expires_at']
          provider.save!
        end
      end
    end
    
    #ap provider
    
    session[:user_id]     = user.id
    session[:account_id]  = user.account_id
    
    
    ap user 
    
    unless account        = Account.where(user_id: user.id).first
      account             = User.create_a_new_account_for_the user
    end
    account.visits        += 1
    account.save!

    user.create_activity(  :signed_in, 
                       owner: current_user,
                   recipient: current_user,
              recipient_type: current_user.class.name,
                  account_id: user.account_id)
     
    go_to = session[:landing_page] 
    session[:landing_page]    = nil            
    redirect_to go_to|| user_path(current_user)      
  end

end