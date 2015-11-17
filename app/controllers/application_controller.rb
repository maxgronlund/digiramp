class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl if: :ssl_configured?
  helper_method :sort_column, :sort_direction

    
  
  
  protect_from_forgery with: :exception
  
  # activity logging
  include PublicActivity::StoreController
  

  before_action :set_defaults
  before_filter :set_paper_trail_whodunnit
  
  def set_defaults
    @body_color = "#FFFFFF"
    #session[:return_url] = nil
  end

  
  def current_user
    #redirect_to root_path
    #User.where(email: 'test06@digiramp.com').first
    begin
      @current_user ||= User.find(cookies.permanent[:user_id]) if cookies.permanent[:user_id]
    rescue
      cookies.permanent[:user_id] = nil
    end
    unless @current_user
      @current_user ||= User.cached_find_by_auth_token( cookies[:auth_token] ) if cookies[:auth_token]
    end
    zaap_cokkies if @current_user.nil?
    #ap '=================================================================================='
    #ap @current_user.email
    #ap '=================================================================================='
    @current_user
  end
  helper_method :current_user
  hide_action :current_user
  
  def ssl_configured?
    #!Rails.env.development?
    Rails.env.production?
  end
  
  def current_account
    begin
      return  Account.cached_find( session[:account_id]) if session[:account_id]
      session[:account_id]    = current_user.account.id
      return  Account.cached_find( current_user.account.id ) 
    rescue
      return nil
    end
  end
  helper_method :current_account
  
  # update within a month 02/06/2015
  def current_account_user
    get_account_user
    #@current_account_user ||= get_account_user
  end
  helper_method :current_account_user
  
  # update within a month 02/06/2015
  def current_catalog_user
    @catalog_users ||= get_catalog_user
    #get_catalog_user
  end
  helper_method :current_catalog_user 
  
  def get_account_user
    if super? 
      AccountUser.find_by(id: current_user.super_account_user_id)
    else 
      if current_account && current_user
        AccountUser.cached_where( current_account.id, current_user.id)
      end
    end
  end
  
  def get_catalog_user
    if super? 
      CatalogUser.find_by(id: current_user.super_catalog_user_id)
    else 
      @catalog.catalog_users.find_by(user_id: current_user.id )
    end
  end
  
  def super?
    @super ||= current_user && current_user.super?
  end
  helper_method :super?
  
  def editor?
    @editor ||= super? || (current_user && current_user.editor?)
  end
  helper_method :editor?
  
  def can_sell?
    super? || (current_user && current_user.salesperson?)
  end
  helper_method :can_sell?
   
  
  def user_signed_in?
    current_user != nil
  end
  
  def profile_user?
    return true if super?
    return false unless current_user
    return false unless current_user.current_account_id
    current_user.current_account_id == current_account.id
  end
  
  
  def admin_only
    unless  super?
      forbidden
    end
    @user       = current_user
    @authorized = true
  end
  
  def editor_only
    unless  super? || editor?
      forbidden
    end
    @user       = current_user
    @authorized = true
  end
  
  def sales_only
    forbidden unless ( super? || (current_user && current_user.salesperson) )
  end
  
  def zaap_cokkies
    cookies[:auth_token] = nil
    cookies.permanent[:user_id]    = nil
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
  
  def redirect_to_special_url default_url
    if  session[:return_to_special_url]
      go_to = session[:return_to_special_url]
       session[:return_to_special_url] = nil
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
    forbidden unless super?
    @user       = current_user
    @authorized = true
  end
  helper_method :admins_only
  
  def permit_creative_project_user
    return if super?
    forbidden unless current_user
    forbidden unless CreativeProjectUser.where(creative_project_id: params[:creative_project_id], 
                                                user_id: current_user.id,
                                                approved_by_project_manager: true).first
  end
  helper_method :permit_creative_project_user
  
  #def account_administrator?
  #  if current_user
  #    
  #  end
  #  false
  #end


  def access_user
    if current_user
      begin
        if params[:user_id]
          @user = User.cached_find(params[:user_id])
        else
          @user = User.cached_find(params[:id])
        end
        forbidden unless @user.permits? current_user
      rescue
        not_found
      end
    else
      forbidden
    end
  end
  helper_method :access_user

  # v 2
  def get_user
    # user id is not passed
    # could be called from the player or endless pages
    return unless params[:user_id]
    begin
      @user = User.friendly.find(params[:user_id])
      set_account
      return @user
    rescue ActiveRecord::RecordNotFound
      not_found
    end
  end
  helper_method :get_user
  
  
  def get_private_user
    get_user
    unless current_user && current_user.super?
      forbidden if current_user.id != @user.id
    end
  end
  helper_method :get_private_user
  
  
  def get_account
    if params[:account_id]
      if @account = Account.cached_find(params[:account_id])
        @user = @account.user
        set_account
      end
    else
      not_found
    end
  end
  helper_method :get_account

  
  
  def current_url(overwrite={})
    url_for :only_path => false, :params => params.merge(overwrite)
  end
  helper_method :current_url

  
  def account_belongs_to_current_user
    @account.user_id == current_user.id
  end
  
  def user_is_an_account_user
    AccountUser.cached_where(@account.id, current_user.id )
  end
  
  
  def forbidden options = {}
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  end
  helper_method :forbidden


  
  def not_found options = {}
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  helper_method :not_found
  
private

  def set_authorized
    return false unless current_user
    @authorized = false
    if current_user.id == @user.id || current_user.super?
      @authorized = true
    end
  end
  
  def set_account
    #@user = current_user if @user.nil
    if @user.account.id.nil?
       @user.account.id = Account.where(user_id: @user.id).first.id
       @user.save!
    end
    session[:account_id] = @user.account.id 
    
    if current_user 
      if current_user.current_account_id != current_user.account.id
        current_user.current_account_id  = current_user.account.id
        current_user.save!
      end
      
    end
    set_authorized
  end
  

  # get the order
  def current_order

    if current_user 
      @order = current_user.get_order
    else
      if session[:order_id] && (@order = Shop::Order.cached_find(session[:order_id]) )
      else 
        @order = Shop::Order.new( invoice_nr: Admin.get_invoice_nr)
        @order.save(validate: false)
        session[:order_id] = @order.id
      end
    end
    @order
  end

  
end
