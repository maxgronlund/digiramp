class AddContentController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    if current_user.can_manage 'add_music', @account
      @work_blog          = Blog.add_content
      @create_content     = BlogPost.where(identifier: 'Create Content', blog_id: @work_blog.id).first_or_create(identifier: 'Create Content', blog_id: @work_blog.id, title: 'Create Content', body: 'Add content to manage') 
      @upload_content     = BlogPost.where(identifier: 'Upload Content', blog_id: @work_blog.id).first_or_create(identifier: 'Upload Content', blog_id: @work_blog.id, title: 'Upload Content', body: 'Create a single work') 
      @import_content     = BlogPost.where(identifier: 'Import Content', blog_id: @work_blog.id).first_or_create(identifier: 'Import Content', blog_id: @work_blog.id, title: 'Import Content', body: 'Create multiply works') 
      @recording_blog     = Blog.add_recording
      @upload_recording   = BlogPost.where(identifier: 'Upload Recording', blog_id: @recording_blog.id).first_or_create(identifier: 'Upload Recording', blog_id: @recording_blog.id, title: 'Upload Recording', body: 'Upload a recording') 
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
