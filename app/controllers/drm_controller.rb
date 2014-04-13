class DrmController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    #@blog  = Blog.collect
    #@drm   = BlogPost.where(identifier: 'DRM', blog_id: @blog.id).first_or_create(identifier: 'DRM', blog_id: @blog.id, title: 'DIGITAL RIGHTS', body: '') 
  end
end
