class PromotionController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  def index
    #@blog       = Blog.promotion
    #@promotion  = BlogPost.where(identifier: 'Promotion', blog_id: @blog.id).first_or_create(identifier: 'Promotion', blog_id: @blog.id, title: 'Promotion', body: 'Distribute content') 
  end
end
