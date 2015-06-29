class User::DownloadsController < ApplicationController
  before_action :access_user
  
  def index
    @recording_downloads = @user.recording_downloads
  end
  
  def show
    recording_download  = RecordingDownload.find_by(uuid: params[:id])
    recording           = recording_download.recording
    @download_url       = recording.download_url2
    
   
  end
  
  #def show
  #  if recording_download = RecordingDowload.find_by(uuid: params[:id])
  #    recording = Recording.find(recording_download.recording_id)
  #  end
  #end
end
