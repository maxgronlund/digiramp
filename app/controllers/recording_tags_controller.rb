class RecordingTagsController < ApplicationController
  
  before_filter :get_user, only: [:show, :edit, :update]
  
  def edit
    @recording      = Recording.cached_find(params[:id])
    @user           = User.cached_find(params[:user_id])
  end

  def update
    go_to = params[:recording][:next_step]
    params[:recording].delete :next_step
    
    @recording      = Recording.cached_find(params[:id])
    @recording.update_attributes(recording_params)
    
    if go_to == 'next_step'
      redirect_to edit_user_recording_persona_path(@recording.user, @recording)
    else
      redirect_to user_recording_path( @recording.user, @recording )
    end
    
    
    
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
