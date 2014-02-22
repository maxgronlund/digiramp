class UploadRecordingsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def new
    @recording_blog   = Blog.add_recording
    @new_recording   = BlogPost.where(identifier: 'New Recording', blog_id: @recording_blog.id).first_or_create(identifier: 'New Recording', blog_id: @recording_blog.id, title: 'New Recording', body: 'New recording')
    @recording = Recording.new
  end

  def edit
  end
end
