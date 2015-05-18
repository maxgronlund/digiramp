class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl if: :ssl_configured?
  helper_method :sort_column, :sort_direction
    
  
  
  protect_from_forgery with: :exception
  
  # activity logging
  include PublicActivity::StoreController
  

  before_action :set_defaults
  
  def set_defaults
    @body_color = "#DDDDDD"
    #session[:return_url] = nil
  end

  
  def current_user
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
      session[:account_id] = current_user.account_id
      return  Account.cached_find( current_user.account_id ) 
    rescue
      return nil
    end
  end
  helper_method :current_account
  
  def current_account_user
    
    account_user = AccountUser.cached_where( current_account.id, current_user.id)
    # this is a fix should be fixed by a migration
    return account_user if account_user
    if super?
      account_user = AccountUser.create(user_id: current_user.id, account_id: current_account.id)
      account_user.grand_all_permissions
    end
    account_user
  end
  helper_method :current_account_user
  
  def current_catalog_user
    catalog_user = @catalog.catalog_users.where(user_id: current_user.id ).first
    return catalog_user if catalog_user
    if super?
      catalog_user = CatalogUser.create(user_id: current_user.id, catalog_id: @catalog.id)
      catalog_user.update_to_super
    end
  end
  helper_method :current_catalog_user 
  
  def super?
    current_user && current_user.super?
  end
  helper_method :super?
   
  def user_signed_in?
    current_user != nil
  end
  
  def admin_only
    unless  user_signed_in?  && current_user.super?
      forbidden
      
    end
    @user       = current_user
    @authorized = true
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
  
  #def there_is_access_to_the_account
  #  forbidden unless access_to_account
  #end
  #helper_method :there_is_access_to_the_account
  
  
  
  def admins_only
    forbidden unless current_user && current_user.can_edit?
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

  def access_user
    unless current_user
      forbidden params
    else
      if params[:user_id]
        @user = User.cached_find(params[:user_id])
      else
        @user = User.cached_find(params[:id])
      end
      begin
        forbidden( params ) unless @user.permits? current_user
      rescue
        #ap '======================= not found ================='
        params[:id] = 0
        not_found params
      end
    end
  end
  helper_method :access_user

  # v 2
  def get_user
    begin
      @user = User.friendly.find(params[:user_id])
      #set_authorized
      set_account
      return @user
    rescue ActiveRecord::RecordNotFound
      not_found id: params[:user_id]
    end
  end
  helper_method :get_user
  
  def get_private_user
    get_user
    unless current_user.super?
      forbidden if current_user.id != @user.id
    end
  end
  helper_method :get_private_user
  
  # v2 
  # used by the account namespace to find the right account
  # and the accounts user
  def get_account_user
    if params[:id]
      if @account = Account.cached_find(params[:id])
        @user = @account.user
        #set_authorized
        set_account
      end
    else
      not_found
    end
  end
  helper_method :get_account_user
  
  def get_account
    if params[:account_id]
      if @account = Account.cached_find(params[:account_id])
        @user = @account.user
        #set_authorized
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
    if params[:controller] && options[:controller] == 'messages'
      if current_user
        session[:request_url]  =  request.url
        redirect_to error_not_found_path( error_id: options[:id], 
                                          user_id: options[:user_id], 
                                          error_type: 'log_in_as_new_user_to_read_message'
                                          )
      else
        session[:request_url]  =  request.url
        
        redirect_to error_not_found_path( error_id: 0, 
                                          user_id: options[:user_id], 
                                          error_type: 'log_in_to_read_message')
        
      end
    else
      session[:request_url] = request.url
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
      # redirect_to error_not_found_path 0
    end
  end
  helper_method :forbidden


  
  def not_found options = {}
    
    if params[:controller]
      if current_user
        
        redirect_to error_not_found_path( error_id: options[:id] || params[:id], 
                                          user_id: options[:user_id], 
                                          error_type: params[:controller],
                                          redirect_to_message:  request.url, 
                                          action: params[:action])
      else
        
        redirect_to error_not_found_path( error_id: options[:id] || params[:id],
                                          error_type: params[:controller],
                                          redirect_to_message:  request.url, 
                                          action: params[:action])
      end
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end
  helper_method :forbidden
  
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
    if @user.account_id.nil?
       @user.account_id = Account.where(user_id: @user.id).first.id
       @user.save!
    end
    session[:account_id] = @user.account_id 
    
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
      order = current_user.get_order
    else
      if session[:order_uuid] && (order = Shop::Order.find_by(uuid: session[:order_uuid]) )
      else 
        order = Shop::Order.create(uuid: UUIDTools::UUID.timestamp_create().to_s)
        session[:order_uuid] = order.uuid
      end
    end
    order
  end
  
  
  
  #def current_cart
  #  Cart.find(session[:cart_id])
  #  rescue ActiveRecord::RecordNotFound
  #  cart = Cart.create
  #  session[:cart_id] = cart.id
  #  cart
  #end
  
  
  
  
  
  
  
end
