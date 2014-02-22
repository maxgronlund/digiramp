class UploadRecordingsController < ApplicationController
  before_filter :there_is_access_to_the_account
  before_filter :get_blog
  def new
    
    @new_recording   = BlogPost.where(identifier: 'New Recording', blog_id: @blog.id).first_or_create(identifier: 'New Recording', blog_id: @blog.id, title: 'New Recording', body: 'New recording')
    @recording = Recording.new
  end

  def edit
  end
  
  def get_blog
    @blog   = Blog.add_recording
  end
end
