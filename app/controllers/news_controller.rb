class NewsController < ApplicationController
  before_filter :get_user, only: [:index]
  def index
    
    @news_blog = Blog.cached_find('news blog')
    @user.news_count = @news_blog.blog_posts.count
    @user.save!
  end
end
