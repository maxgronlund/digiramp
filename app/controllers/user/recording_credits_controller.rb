class User::RecordingCreditsController < ApplicationController
  
  before_filter :access_user
  
  def show
    
  end

  def edit
    @recording = Recording.cached_find(params[:id])
  end
  
  def update
    if params[:recording]
      @recording = Recording.cached_find(params[:recording_id])
      
      @recording.update_attributes(recording_params) 
      @recording.confirm_ipis
    end
    redirect_to :back
    #
    #if params[:commit] == 'Save'
    #  redirect_to edit_user_recording_right_path(@recording.user, @recording)
    #else
    #  redirect_to user_recording_path( @recording.user, @recording )
    #end

  end
  
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
  