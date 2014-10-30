class RecordingTagsController < ApplicationController
  def edit
    @recording      = Recording.cached_find(params[:id])
    @user           = User.cached_find(params[:user_id])
  end

  def update
    @recording      = Recording.cached_find(params[:id])
    @recording.update_attributes(recording_params)
    
    redirect_to edit_user_recording_right_path(@recording.user, @recording)
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
