class SessionsController < ApplicationController

  
  def create
    session[:show_profile_completeness] = true
    
    if user = current_user
      attach_authorization_provider_to_existing_user( env, user )
    
    elsif env['omniauth.auth']
      log_in_up_or_sign_up_with_omniauth env

    else
      log_in_with_email params
    end
  end
  
  
  
  
  
  # the user is all readdy logged in 
  # so we are attaching a provider to an existing account
  def attach_authorization_provider_to_existing_user env, user
    # '-------------- SessionsController#attach_authorization_provider_to_existing_user -----------'
    
    unless Omniauth.attach_provider( env, user )
      flash[:info] = { title: "Notice: ", body: "Provider already attached to account" }
    else
      flash[:info] = { title: "SUCCESS: ", body: "#{env['omniauth.auth'][:provider].upcase} is linked to your account" }
    end

    redirect_to session[:current_page]
  end
  
  
  
  
  
  # log in / signing up with omniauthor
  def log_in_up_or_sign_up_with_omniauth env
    # '-------------- SessionsController#log_in_up_or_sign_up_with_omniauth -----------'
    
    user = Omniauth.authorize_with_omniauth( env['omniauth.auth'] )
    if user[:user]
      
      initialize_session_for user[:user]
      
    else
      flash[:danger] = { title: "Sorry", body: user[:message]}
      redirect_to login_new_path
    end
  end
  
  
  
  
  
  def log_in_with_email params
    # '-------------- SessionsController#log_in_with_email -----------'
     
    params[:sessions][:email]  = params[:sessions][:email].downcase
    user = User.where(email: params[:sessions][:email]).first
    
    if user && user.authenticate(params[:sessions][:password])
    
      if params[:remember_me]
        # is this enough?
        cookies.permanent[:user_id]      = user.id
        cookies.permanent[:auth_token]   = user.auth_token
      else
        cookies[:auth_token]           = user.auth_token  
      end
      initialize_session_for user
    else

      flash[:danger] = { title: "Sorry", body: "No user we can't authorize found.
                                                If you have signed up directly on DigiRAMP we can resend you password.
                                                Otherwise make sure you are signed in with you authorization provider" }
      redirect_to login_new_path
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
    cookies.delete(:user_id)
    #reset_session
    
    if params[:opportunity_id]
      redirect_to :back
    elsif params[:opportunity_invitation]
      flash[:info] = { title: "Ok", body: "Please login as the user invited to the opportunity" }
      redirect_to login_new_path(params) 
    elsif params[:redirect_to_message]
      session[:current_page] = params[:redirect_to_message]
      redirect_to login_new_path
    else
      redirect_to root_url, notice: "Logged out!"
    end
  end
  
  def share_recording user
    
  end
  
private
  
  def initialize_session_for user
    # '-------------- SessionsController#initialize_session_for -----------'
    # params
    # session[:current_page]

    provider = nil
    if env['omniauth.auth']
      if credentials                =  env['omniauth.auth']["credentials"]
        if provider                 = user.authorization_providers.where(provider: env['omniauth.auth']['provider']).first
          provider.oauth_token      = credentials['token']        if credentials['token']
          provider.oauth_expires_at = credentials['expires_at']   if credentials['expires_at']
          provider.save!
        end
      end
    end
    
    
    session[:user_id]           = user.id
    cookies.permanent[:user_id] = user.id
    session[:account_id]        = user.account_id
    
     
    # hmm.. some error handling should not be needed   
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
     
    #go_to = session[:landing_page] 
    #session[:landing_page]    = nil
    if recording_id = session[:share_recording_id]   
      session[:share_recording_id]   = nil
      # switch provider
      case provider.provider
      when 'facebook'
        redirect_to share_on_facebook_path(user.id, recording_id: recording_id  )
      when 'twitter'
        redirect_to share_on_twitter_path(user.id, recording_id: recording_id  )
      #else
      #  goto = session[:current_page]
      #  session[:current_page] = nil
      #  redirect_to goto
      end
      #elsif session[:redirect_to_message]
      #  goto = session[:redirect_to_message]
      #  session[:redirect_to_message] = nil
      #  redirect_to goto
    elsif session[:go_to_message]
      go_to = session[:go_to_message]
      session[:go_to_message] = nil
      redirect_to go_to
    else  
      redirect_to session[:current_page]
    
      
    end
      
  end

end