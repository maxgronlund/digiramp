class UploadRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_filter :there_is_access_to_the_account
  #before_filter :get_blog
  def new

    @recording        = Recording.new
  end
  
  #def update
  #  
  #  #logger.debug("PARAMS: #{params[:transloadit].inspect}")
  #  @recording = Recording.new(audio_upload: params[:transloadit], account_id: @account.id, title: 'new')
  #  
  #  
  #  @recording.title      =  @recording.audio_upload[:uploads][0][:name]
  #  @recording.mp3        = @recording.audio_upload[:results][:mp3][0][:url]
  #  @recording.waveform   = @recording.audio_upload[:results][:waveform][0][:url]
  #  @recording.thumbnail  = @recording.audio_upload[:results][:thumbnail][0][:url]
  #  #@recording.category   = 'none'
  #  @recording.save!
  #  @recording.update_completeness
  #  
  #  #redirect_to account_recording_upload_completed_path(@account, @recording )
  #  
  #  #redirect_to account_recording_path(@account, @recording )
  #end
  
  
  def create
    
    @import_batch = TransloaditParser.parse_recordings( params[:transloadit], @account.id )
    redirect_to account_import_batch_path(@account,   @import_batch)
  end
  
  def extrace_tags_for genre_string
    genres = genre_string.split(',')
  end
  
  def index
    
  end
  

  def edit
  end
  
  def update
    
  end
  
  #def get_blog
  #  @blog   = Blog.add_recording
  #end
end
