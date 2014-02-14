class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def current_user
    begin
      #@current_user ||= User.find(session[:user_id])
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
    rescue
      #session[:user_id] = nil
      cookies.delete(:auth_token)
    end
  end
  
  def user_signed_in?
    current_user != nil
  end
  
  def admin_only
    logger.debug '----------------------------------------------------------------'
    logger.debug current_user.inspect
    logger.debug '----------------------------------------------------------------'
    unless  user_signed_in?  && current_user.super?
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
    #user_signed_in?
    #raise ActionController::RoutingError.new('Not Found')
    #render text: "422 Not Found", status: 422
  end
  
  def zaap_cokkies
    cookies[:auth_token] = nil
    session[:user_id]    = nil
  end
  
#private
#  
#  def check_authorization
#      raise User::NotAuthorized unless current_user.admin?
#  end
  
end
