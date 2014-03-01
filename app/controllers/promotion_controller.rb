class PromotionController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @blog       = Blog.promotion
    @promotion  = BlogPost.where(identifier: 'Promotion', blog_id: @blog.id).first_or_create(identifier: 'Promotion', blog_id: @blog.id, title: 'Promotion', body: 'Distribute content') 
  end
end
