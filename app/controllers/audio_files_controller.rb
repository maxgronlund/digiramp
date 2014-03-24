class AudioFilesController < ApplicationController
  before_filter :there_is_access_to_the_account
  include Transloadit::Rails::ParamsDecoder
  
  
  def edit
    @recording            = Recording.cached_find(params[:id])
    @common_work          = CommonWork.cached_find(params[:common_work_id])
    
  end
  
  def update
    
    flash[:info] = { title: "SUCCESS: ", body: "Audio file uploaded" }
    @recording              = Recording.cached_find(params[:id])
    @common_work            = CommonWork.cached_find(params[:common_work_id])
    @recording.audio_upload =  params[:transloadit]

    #logger.debug("PARAMS: #{params[:transloadit].inspect}")

    @recording.mp3          =  @recording.audio_upload[:results][:mp3][0][:url]
    @recording.waveform     =  @recording.audio_upload[:results][:waveform][0][:url]
    @recording.thumbnail    =  @recording.audio_upload[:results][:thumbnail][0][:url]

    @recording.save!
    @recording.update_completeness
    
    redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording )
    
    #redirect_to account_recording_path(@account, @recording )
  end
  
  
  
  #def new
  #  @recording            = Recording.cached_find(params[:recording_id])
  # 
  #  redirect_to :back
  #end
  #
  #def destroy
  #  @recording            = Recording.cached_find(params[:recording_id])
  # 
  #  redirect_to :back
  #end
  #
  #def update_recording
  # 
  #end
  
  
end
