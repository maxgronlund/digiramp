class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  
  def current_user
    begin
      #@current_user ||= User.find(session[:user_id])
      @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
    rescue
      #session[:user_id] = nil
      cookies.delete(:auth_token)
    end
  end
  helper_method :current_user
  
  def user_signed_in?
    current_user != nil
  end
  
  def admin_only
    
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
  
  def redirect_to_return_url default_url
    if  session[:return_url]
      go_to = session[:return_url]
       session[:return_url] = nil
      redirect_to go_to
    else
      redirect_to default_url
    end
  end
  
  def there_is_access_to_the_account
    forbidden unless access_to_account
  end
  helper_method :there_is_access_to_the_account
  
  def account_belongs_to_current_user
    @account.user_id == current_user.id
  end
  
  def user_is_an_account_user
    # TO DO
    false
  end
  
  def forbidden
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  end
  helper_method :forbidden
  
private
  def access_to_account
    return false if current_user == nil
    begin
      @account = Account.find(params[:id])
    rescue
      @account = Account.find(params[:account_id])
    end
    return true if account_belongs_to_current_user
    return true if user_is_an_account_user
    return true if current_user.role == 'admin' || current_user.role == 'super'
    @account = nil
    false
  end
  
end
