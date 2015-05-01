class UserRecordingAssetsController < ApplicationController
  before_action :access_user
  
  def show
    @recording = Recording.cached_find(params[:id]) 
    forbidden unless @recording.read_recording_ids.include?   current_user.id
  end
  
 

end
