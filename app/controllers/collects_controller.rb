class CollectsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @blog     = Blog.collect
    @collect   = BlogPost.where(identifier: 'Collect', blog_id: @blog.id).first_or_create(identifier: 'Collect', blog_id: @blog.id, title: 'Collect', body: 'Payments') 
  end
end
