class AccountsController < ApplicationController
  before_filter :there_is_access_to_the_account

  def show
    
    #change this based on the account state
    @blog             = Blog.welcome
    if @account.title.to_s == @account.user.email
      @welcome   = BlogPost.where(identifier: 'Welcome', blog_id: @blog.id).
                                  first_or_create(identifier: 'Welcome', blog_id: @blog.id, title: 'Welcome')  
    end
    
    if @account.common_works.size == 0
      @add_content      = BlogPost.where( identifier: 'Add Content', blog_id: @blog.id).
                                  first_or_create(identifier: 'Add Content', blog_id: @blog.id, title: 'Add Content') 
    end

    @account_users  = @account.account_users.order('role asc')
    if @account_users.size < 2
      @add_first_users  = BlogPost.where(identifier: 'Add Users', blog_id: @blog.id).
                                  first_or_create(identifier: 'Add Users', blog_id: @blog.id, title: 'Add Users') 
    end
    
    @show_users = current_user.can_administrate( @account) && @account_users.size > 1
    
    if current_user.current_account_id != @account.id
      current_user.current_account_id = @account.id
      current_user.save!
      @account.visits += 1
      @account.save!
    end
  end
  
  def edit
    
  end
  
  
  
  
end
