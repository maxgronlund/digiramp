class User::SelectProductTypeController < User::UserController
  before_action :access_user
  def index
    @blog               = Blog.cached_find('create product')
    @recording_product  = BlogPost.cached_find('recording' , @blog)
    @playlist_product   = BlogPost.cached_find('playlist' , @blog)
    @physical_product   = BlogPost.cached_find('physical product' , @blog)
    @service_product    = BlogPost.cached_find('service' , @blog)
    @download_product   = BlogPost.cached_find('download' , @blog)
    @streaming_product  = BlogPost.cached_find('streaming' , @blog)
  end
end
