class AccountsController < ApplicationController
  before_filter :there_is_access_to_the_account

  def show
    

    
    #if @account.rec_cache_version == 0
    if @account.has_no_name?
      @account_status = 'enter_account_name'
      @account.raise_cache_version
    elsif @account.owner_has_no_name?
      @account_status = 'enter_user_name'
      @account.raise_cache_version
    elsif @account.show_welcome_message?
      @account_status = 'welcome'
    else
      @account_status = 'dashboard'
    end
    
    #if @account.title.to_s == @account.user.email
    #  @welcome   = BlogPost.where(identifier: 'Welcome', blog_id: @blog.id).
    #                              first_or_create(identifier: 'Welcome', blog_id: @blog.id, title: 'Welcome')  
    #end
    
    #if @account.common_works.size == 0
    #  @add_content      = BlogPost.where( identifier: 'Add Content', blog_id: @blog.id).
    #                              first_or_create(identifier: 'Add Content', blog_id: @blog.id, title: 'Add Content') 
    #end
    #
    #@account_users  = @account.account_users.order('role asc')
    #if @account_users.size == 0
    #  @add_first_users  = BlogPost.where(identifier: 'Add Users', blog_id: @blog.id).
    #                              first_or_create(identifier: 'Add Users', blog_id: @blog.id, title: 'Add Users') 
    #end
    @account_users  = @account.account_users.order('role asc')
    @show_users = current_user.can_administrate( @account) && @account_users.size > 1
    
    # this hould be updated
    if current_user.current_account_id != @account.id
      current_user.current_account_id = @account.id
      current_user.save!
      current_user.flush_auth_token_cache(cookies[:auth_token])
      @account.visits += 1
      @account.save!
    end
    
    
    
    
  end
  
  def edit
    
  end
  
  def update
    params[:account][:rec_cache_version] = @account.rec_cache_version + 1    
    @account.update_attributes(account_params)
    redirect_to_return_url account_path( @account)
  end
  
  def account_params
    params.require(:account).permit!
  end

 
  

end
