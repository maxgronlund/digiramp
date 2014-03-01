class CustomersController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @blog         = Blog.collect
    @customers   = BlogPost.where(identifier: 'Customers', blog_id: @blog.id).first_or_create(identifier: 'Customers', blog_id: @blog.id, title: 'Customers', body: '') 
  end
end
