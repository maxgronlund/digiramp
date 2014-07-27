class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  before_filter :store_landing_page
  
  
  def store_landing_page
    if current_user.nil? && session[:landing_page].nil?
      session[:landing_page]  = request.url 
    end
    puts '-----------------------------------------------'
    puts session[:landing_page]
    puts '-----------------------------------------------'
  end
  
  def current_user
    begin
      @current_user ||= User.cached_find_by_auth_token( cookies[:auth_token] ) if cookies[:auth_token]
    rescue
      zaap_cokkies
    end
  end
  helper_method :current_user
  
  def current_account
    begin
      return  Account.cached_find( session[:account_id]) if session[:account_id]
      return  Account.cached_find( current_user.account_id ) 
    rescue
      session[:account_id] = current_user.account_id
      return  Account.cached_find( current_user.account_id ) 
    end
  end
  helper_method :current_account
  
  def current_account_user
    AccountUser.cached_where( current_account.id, current_user.id)
  end
  helper_method :current_account_user
  
  def current_catalog_user
    @catalog.catalog_users.where(user_id: current_user.id ).first
  end
  helper_method :current_catalog_user 
  
  
  def user_signed_in?
    current_user != nil
  end
  
  def admin_only
    unless  user_signed_in?  && current_user.super?
      forbidden
    end
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
  
  #def there_is_access_to_the_account
  #  forbidden unless access_to_account
  #end
  #helper_method :there_is_access_to_the_account
  
  
  
  def admins_only
    forbidden unless current_user.can_edit?
  end
  helper_method :admins_only
  
  
  def access_user
    unless current_user
      forbidden 
    else
      if params[:user_id]
        @user = User.cached_find(params[:user_id])
      else
        @user = User.cached_find(params[:id])
      end
      forbidden unless @user.permits? current_user
    end
  end
  helper_method :access_user
  
  
  def account_belongs_to_current_user
    @account.user_id == current_user.id
  end
  
  def user_is_an_account_user
    AccountUser.cached_where(@account.id, current_user.id )
  end

  def forbidden
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  end
  helper_method :forbidden
  
  def not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  helper_method :forbidden
  
private

  
end
