class SessionsController < ApplicationController

  
  def create    
    
    session[:show_profile_completeness] = true
    
    if user = current_user
      attach_authorization_provider_to_existing_user( env, user )
    
    elsif env['omniauth.auth']
      log_in_up_or_sign_up_with_omniauth env

    #elsif params[:provider] == 'facebook'
    #  @facebook_cookies ||= Koala::Facebook::OAuth.new(FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret_key']).get_user_info_from_cookie(cookies)
    #  @graph = Koala::Facebook::API.new(@facebook_cookies['access_token'])
    #  # @graph.get_object("me")
    else
      log_in_with_email params
    end
  end
  
  def index
    if current_user
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
  
  
  
  
  
  # the user is all readdy logged in 
  # so we are attaching a provider to an existing account
  def attach_authorization_provider_to_existing_user env, user
    # '-------------- SessionsController#attach_authorization_provider_to_existing_user -----------'
    
    unless Omniauth.attach_provider( env, user )
      flash[:info] = "Provider already attached to account" 
    else
      flash[:info] = "#{env['omniauth.auth'][:provider].upcase} is linked to your account" 
    end
    user.update_shop
    redirect_to session[:current_page]
  end
  
  
  
  
  
  # log in / signing up with omniauthor
  def log_in_up_or_sign_up_with_omniauth env
    # '-------------- SessionsController#log_in_up_or_sign_up_with_omniauth -----------'
    
    user = Omniauth.authorize_with_omniauth( env['omniauth.auth'] )
    if user[:user]
      initialize_session_for user[:user]
    else
      flash[:danger] =  user[:message]
      redirect_to login_new_path
    end
  end
  
  
  
  
  
  def log_in_with_email params

    params[:sessions][:email]  = params[:sessions][:email].downcase
    user = User.where(email: params[:sessions][:email]).first
    ap user
    if user && user.confirmed_at.nil?
      redirect_to not_confirmed_signup_confirmation_path(user.confirmation_token)
    else
    
      if user && user.authenticate(params[:sessions][:password])
      
        if params[:remember_me]
          # is this enough?
          cookies.permanent[:user_id]      = user.id
          cookies.permanent[:auth_token]   = user.auth_token
        else
          cookies[:auth_token]             = user.auth_token  
        end
        initialize_session_for user
      else
      
        flash[:danger] =  "No user we can't authorize found.
                           If you have signed up directly on DigiRAMP we can resend you password.
                           Otherwise make sure you are signed in with you authorization provider" 
        redirect_to login_new_path
      end
    end
    
  end
  


  def destroy
    
    begin 
      user = User.cached_find_by_auth_token( cookies[:auth_token] )
      user.flush_auth_token_cache(cookies[:auth_token])
      
      user.create_activity(  :logged_out, 
                         owner: user,
                     recipient: user,
                recipient_type: user.class.name,
                    account_id: user.account.id)       
    rescue
    end
    cookies.delete(:auth_token)
    cookies.delete(:user_id)
    
    session[:share_recording_id]        = nil
    session[:show_profile_completeness] = nil
    session[:request_url]               = nil
    #reset_session
    
    if params[:opportunity_id]
      redirect_to :back
    elsif params[:opportunity_invitation]
      flash[:info] =  "Please login as the user invited to the opportunity" 
      redirect_to login_new_path(params) 
    elsif params[:redirect_to_message]
      session[:current_page] = params[:redirect_to_message]
      redirect_to login_new_path
    elsif params[:redirect_to_accept_invitation]
      redirect_to params[:redirect_to_accept_invitation]
    else
      redirect_to root_url
    end
  end
  
  def share_recording user
    
  end
  
private
  
  def initialize_session_for user
 
    
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
    
    
    #session[:user_id]           = user.id
    cookies.permanent[:user_id] = user.id
    session[:account_id]        = user.account.id
    
    user.merge_order(session[:order_id]) unless session[:order_id].nil?
    session[:order_id] = nil

    user.account.visits        += 1
    user.account.save!

    user.create_activity(  :signed_in, 
                       owner: current_user,
                   recipient: current_user,
              recipient_type: current_user.class.name,
                  account_id: user.account.id)
     

    if session[:request_url]
      go_to = session[:request_url]
      session[:request_url] = nil
      

      redirect_to go_to

    
    elsif recording_id = session[:share_recording_id]   
      session[:share_recording_id]   = nil
      # switch provider
      if provider
        case provider.provider
        when 'facebook'
          redirect_to share_on_facebook_path(user.id, recording_id: recording_id  )
        when 'twitter'
          redirect_to share_on_twitter_path(user.id, recording_id: recording_id  )
        else
          goto = session[:current_page]
          session[:current_page] = nil
          redirect_to goto
        end
      else
        session[:share_recording_id]  = nil
        redirect_to session[:current_page]
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
      
      if (session[:current_page] == "http://localhost:3000/") || ( session[:current_page] == "https://digiramp.com/")
        session[:current_page] = user_path(current_user)
        if current_user.user_configuration.updated_at + 7.days < DateTime.now
          current_user.user_configuration.reset!
        end
      end
      redirect_to session[:current_page] || user_path(current_user)
    end
  end

end