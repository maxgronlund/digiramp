class RecordingLyricsController < ApplicationController
  
  before_action :get_user, only: [ :edit, :update]
  include RecordingsHelper
  before_action :update_user_recording, only: [ :edit, :update]
  
  
  def edit
    forbidden unless (current_user && @recording.user_id == current_user.id) || super?
    @common_work = @recording.common_work
  end

  def update
    #go_to = params[:recording][:next_step]
    #params[:recording].delete :next_step
    @recording.update_attributes(recording_params)
    redirect_to edit_user_recording_tag_path(@recording.user, @recording)
    #if go_to == 'next_step'
    #  redirect_to edit_user_recording_tag_path(@recording.user, @recording)
    #else
    #  redirect_to user_recording_path( @recording.user, @recording )
    #end
    
    
  end
  
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
end
