class DrmController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  def index
    #@blog  = Blog.collect
    #@drm   = BlogPost.where(identifier: 'DRM', blog_id: @blog.id).first_or_create(identifier: 'DRM', blog_id: @blog.id, title: 'DIGITAL RIGHTS', body: '') 
  end
end
