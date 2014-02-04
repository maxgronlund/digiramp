class AboutController < ApplicationController
  def index
    @blog = Blog.about
  end
end
