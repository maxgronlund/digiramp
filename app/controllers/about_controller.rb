class AboutController < ApplicationController
  def index
    @blog = Blog.about
    @peter = @blog.blog_posts.where(identifier: 'Peter Rafelson').first_or_create(identifier: 'Peter Rafelson', title: 'Peter Rafelson')
  end
end
