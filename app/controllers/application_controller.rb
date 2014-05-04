class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    begin
      @current_user ||= User.cached_find_by_auth_token( cookies[:auth_token] ) if cookies[:auth_token]
    rescue
      cookies.delete(:auth_token)
    end
  end
  helper_method :current_user
  
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
  
  def there_is_access_to_the_account
    forbidden unless access_to_account
  end
  helper_method :there_is_access_to_the_account
  
  def admins_only
    forbidden unless current_user.can_edit?
  end
  helper_method :admins_only
  
  def access_user
    if params[:user_id]
      @user = User.cached_find(params[:user_id])
    else
      @user = User.cached_find(params[:id])
    end
    @account = @user.account
    unless Permissions.can_access_private_account( current_user, @user)
      forbidden
    end
  end
  helper_method :access_user
  
  
  def account_belongs_to_current_user
    @account.user_id == current_user.id
  end
  
  def user_is_an_account_user
    AccountUser.cached_where(@account.id, current_user.id )
  end
  
  def there_is_access_to_catalog
    forbidden unless access_to_catalog
  end
  helper_method :there_is_access_to_catalog
  
  def access_to_catalog
    if params[:catalog_id]
      @catalog = Catalog.cached_find(params[:catalog_id])
    elsif params[:id]
      @catalog = Catalog.cached_find(params[:id])
    end
    return true if current_user.can_administrate @account
  end
  
  
  
  
  def forbidden
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  end
  helper_method :forbidden
  
private
  def access_to_account
    
    return false if current_user == nil
    
    #account_id = params[:id] || params[:account_id]
    if params[:account_id]
      @account = Account.cached_find(params[:account_id])
    else
      @account = Account.cached_find(params[:id])
    end
    #begin
    #  @account = Account.cached_find(params[:id])
    #rescue
    #  @account = Account.cached_find(params[:account_id])
    #end
    return true if account_belongs_to_current_user
    return true if user_is_an_account_user
    return true if current_user.role == 'super'
    
    #return true if the_page_contains_shared_assets
    @account = nil
    #account_belongs_to_current_user.current_account_id = current_user.account_id
    #account_belongs_to_current_user.save
    false
  end
  
  # if the page holds a resource where the current user is granded access
  def the_page_contains_shared_assets
    #return false
  end
  
end
