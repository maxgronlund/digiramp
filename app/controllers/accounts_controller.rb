class AccountsController < ApplicationController
  before_filter :there_is_access_to_the_account

  def show
    
    #change this based on the account state
    @blog             = Blog.welcome
    @account_header   = BlogPost.where(identifier: 'Welcome', blog_id: @blog.id).first_or_create(identifier: 'Welcome', blog_id: @blog.id, title: 'Welcome')  
    
    @add_content      = BlogPost.where(identifier: 'Add Content', blog_id: @blog.id).first_or_create(identifier: 'Add Content', blog_id: @blog.id, title: 'Add Content') 
    @section_left     = 'accounts/shared/add_content'
    
    @blog             = Blog.welcome
    @add_users        = BlogPost.where(identifier: 'Add Users', blog_id: @blog.id).first_or_create(identifier: 'Add Users', blog_id: @blog.id, title: 'Add Users') 
    @section_right    = 'accounts/shared/add_first_users'
  end
  
  
  
  
end
