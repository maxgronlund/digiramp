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
  
  
  
end
