class AccountsController < ApplicationController
  before_filter :there_is_access_to_the_account

  def show
    @blog     = Blog.welcome
    @welcome  = BlogPost.where(identifier: 'welcome', blog_id: @blog.id).first_or_create(identifier: 'welcome', blog_id: @blog.id, title: 'Welcome A') 
    @section = 'accounts/shared/welcome'
  end
  
  
  
  
end
