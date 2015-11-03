class FaqController < ApplicationController
  def index
    PageView.create(url: '/faq' )
    @blog = Blog.cached_find('FAQ')
    @user = current_user
  end
  
  def show
    
  end
end
