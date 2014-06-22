class AccountsController < ApplicationController
  
  include AccountsHelper
  before_filter :access_account
  #before_filter :access_user, only: [:edit, :show]
  
  
  def show

    # repairs an old corupted account
    unless current_account_user
      @account.initialize_account_owner 
      @account.initialize_super_users
      @account.save!
      flash[:info]      = { title: "FYI", body: "User Permissions updated" }
    end

    
    session[:account_id]  = @account.id
    


    #if @account.has_no_name?
    #  @account_status = 'enter_account_name'
    #elsif @account.owner_has_no_name?
    #  @account_status = 'enter_user_name'
    #elsif @account.show_welcome_message?
    #  @account_status = 'welcome'
    #else
    #  @account_status = 'dashboard'
    #end
    
    #if @account.user.nil?
    #  @account.user = @account.account_users.first.user
    #  @account.save
    #end

    #@account_users  = @account.account_users.order('role asc')
    #@show_users = current_user.can_administrate( @account) && @account_users.size > 1
    
    # this should be updated
    #if current_user.current_account_id != @account.id
    #  current_user.current_account_id  = @account.id
    #  current_user.save!
    #  #current_user.flush_auth_token_cache(cookies[:auth_token])
    #  @account.visits += 1
    #  @account.save!
    #end
    
    


  end
  
  def edit
    
    @account = Account.cached_find(params[:id])
    @user = @account.user
  end
  
  def update
    @account  = Account.cached_find(params[:id])
    @account.update_attributes(account_params)
    
    if false
      redirect_to edit_user_path(  @account.user)
    else
      redirect_to account_path(  @account)
    end
    

    @account.update_attributes(account_params)
    

  end
  
  def account_params
    params.require(:account).permit!
  end
  
  

 
  

end
