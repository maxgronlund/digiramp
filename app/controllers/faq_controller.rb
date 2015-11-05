class FaqController < ApplicationController
  def index
    PageView.create(url: '/faq' )
    @blog = Blog.cached_find('FAQ')
    @user = current_user
    #@blog_posts = 
  end
  
  def show
    
  end
end
