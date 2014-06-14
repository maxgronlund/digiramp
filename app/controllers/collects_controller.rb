class CollectsController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  
  def index
    @blog     = Blog.collect
    @collect   = BlogPost.where(identifier: 'Collect', blog_id: @blog.id).first_or_create(identifier: 'Collect', blog_id: @blog.id, title: 'Collect', body: 'Payments') 
  end
end
