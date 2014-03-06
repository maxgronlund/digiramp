class UploadRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_filter :there_is_access_to_the_account
  before_filter :get_blog
  def new
    
    @new_recording    = BlogPost.where(identifier: 'New Recording', blog_id: @blog.id).first_or_create(identifier: 'New Recording', blog_id: @blog.id, title: 'New Recording', body: 'New recording')
    @recording        = Recording.new
  end
  
  def create
    
    Rails.logger.info("PARAMS: #{params[:transloadit].inspect}")
    
    @recording = Recording.new(audio_upload: params[:transloadit], account_id: params[:account_id])
    @recording.save!
    
    redirect_to account_upload_recording_path(@account, @recording)
  end

  def edit
  end
  
  def get_blog
    @blog   = Blog.add_recording
  end
end
