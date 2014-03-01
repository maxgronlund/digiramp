class AssetsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @blog     = Blog.assets
    @assets   = BlogPost.where(identifier: 'Assets', blog_id: @blog.id).first_or_create(identifier: 'Assets', blog_id: @blog.id, title: 'Assets', body: 'All the digital assets') 
    
  end
end
