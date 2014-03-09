class AssetsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @blog         = Blog.assets
    @assets       = BlogPost.where(identifier: 'Assets', blog_id: @blog.id).first_or_create(identifier: 'Assets', blog_id: @blog.id, title: 'Assets', body: 'All the digital assets') 
    @assets       = BlogPost.where(identifier: 'Documents', blog_id: @blog.id).first_or_create(identifier: 'Documents', blog_id: @blog.id, title: 'Documents', body: 'Documents') 
    @recordings   = BlogPost.where(identifier: 'Recordings', blog_id: @blog.id).first_or_create(identifier: 'Recordings', blog_id: @blog.id, title: 'Recordings', body: 'Recordings') 
    @works        = BlogPost.where(identifier: 'Works', blog_id: @blog.id).first_or_create(identifier: 'Works', blog_id: @blog.id, title: 'Works', body: 'Works') 
    @add_music    = BlogPost.where(identifier: 'Add Music', blog_id: @blog.id).first_or_create(identifier: 'Add Music', blog_id: @blog.id, title: 'Add Music', body: 'Add Music') 
    
  end
end
