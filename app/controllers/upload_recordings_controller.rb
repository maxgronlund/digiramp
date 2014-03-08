class UploadRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_filter :there_is_access_to_the_account
  before_filter :get_blog
  def new
    
    @new_recording    = BlogPost.where(identifier: 'New Recording', blog_id: @blog.id).first_or_create(identifier: 'New Recording', blog_id: @blog.id, title: 'New Recording', body: 'New recording')
    @recording        = Recording.new
  end
  
  def create
    
    logger.debug("PARAMS: #{params[:transloadit].inspect}")
    @recording = Recording.new(audio_upload: params[:transloadit], account_id: @account.id, title: params[:title])
    
    
    @recording.title      =  @recording.audio_upload[:uploads][0][:name]
    @recording.mp3        = @recording.audio_upload[:results][:mp3][0][:url]
    @recording.thumbnail  = @recording.audio_upload[:results][:waveform][0][:url]
    @recording.category   = 'none'
    @recording.save!
    
    #@recording.extract_id3_tags_from_audio_file
    
    @recording.update_completeness
    
    redirect_to account_recording_upload_completed_path(@account, @recording )
    
    #redirect_to account_recording_path(@account, @recording )
  end

  def edit
  end
  
  def get_blog
    @blog   = Blog.add_recording
  end
end
