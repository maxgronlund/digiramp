class AudioFileController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_filter :there_is_access_to_the_account
  def edit
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @recording = Recording.cached_find(params[:id])
  end
  
  def update
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @recording = Recording.cached_find(params[:id])
    
    if params[:transloadit] && params[:transloadit][:files_to_store_on_s3] == 0
      @recording.audio_upload = params[:transloadit]
      @recording.mp3          = @recording.audio_upload[:results][:mp3][0][:url]
      @recording.waveform     = @recording.audio_upload[:results][:waveform][0][:url]
      @recording.thumbnail    = @recording.audio_upload[:results][:thumbnail][0][:url]
      @recording.save
      @recording.extract_metadata
      @recording.update_completeness
    end
    
    redirect_to edit_account_common_work_recording_path(@account, @recording.common_work, @recording)

  end
end
