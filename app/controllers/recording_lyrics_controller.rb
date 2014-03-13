class RecordingLyricsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def edit
     @recording      = Recording.find(params[:id])
     @recording.extract_metadata
  end
  
  def update
     @recording      = Recording.find(params[:id])
     @recording.update_attributes(recording_params)

     redirect_to account_recording_upload_completed_path(@account, @recording)

  end
  
  private
  
  def recording_params
    params.require(:recording).permit!
  end
end
