class HelpController < ApplicationController
  def index
    @user = current_user
    @blog       = Blog.cached_find('help')
    @vocabalory = BlogPost.cached_find('vocabolary' , @blog)
  end
end
