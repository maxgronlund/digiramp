class AccountsController < ApplicationController
  
  include AccountsHelper
  before_filter :access_to_account
  

  before_filter :access_user, only: [:edit]
  
  
  def show
    
    @account = Account.cached_find(params[:id])
    

    if @account.has_no_name?
      @account_status = 'enter_account_name'
    elsif @account.owner_has_no_name?
      @account_status = 'enter_user_name'
    elsif @account.show_welcome_message?
      @account_status = 'welcome'
    else
      @account_status = 'dashboard'
    end
    
    #if @account.user.nil?
    #  @account.user = @account.account_users.first.user
    #  @account.save
    #end

    #@account_users  = @account.account_users.order('role asc')
    #@show_users = current_user.can_administrate( @account) && @account_users.size > 1
    
    # this should be updated
    if current_user.current_account_id != @account.id
      current_user.current_account_id = @account.id
      current_user.save!
      current_user.flush_auth_token_cache(cookies[:auth_token])
      @account.visits += 1
      @account.save!
    end

  end
  
  def edit
    @account = Account.cached_find(params[:id])
  end
  
  def update
    @account  = Account.cached_find(params[:id])
    @account.update_attributes(account_params)
    
    if false
      redirect_to edit_user_path(  @account.user)
    else
      redirect_to account_path(  @account)
    end
    
    
    #redirect_to user_account_path( @account.user, @account)

    #if enter_user_name = params[:account][:enter_user_name]   
    #   params[:account].delete :enter_user_name
    #end
    @account.update_attributes(account_params)
    
    #if enter_user_name
    #  redirect_to user_account_path( @account.user, @account)
    #else
    #  redirect_to user_path( @account.user)
    #end
  end
  
  def account_params
    params.require(:account).permit!
  end
  
  

 
  

end
