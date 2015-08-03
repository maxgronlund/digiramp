class User::RecordingCreditsController < ApplicationController
  
  before_action :access_user
  
  def show
    
  end

  def edit
    @recording = Recording.cached_find(params[:id])
  end
  
  def update

    @recording = Recording.cached_find(params[:id])
    
    @recording.update_attributes(recording_params) 
    #@recording.confirm_ipis

    redirect_to user_user_common_work_path(@user, @recording.get_common_work)
    #
    #if params[:commit] == 'Save'
    #  redirect_to edit_user_recording_right_path(@recording.user, @recording)
    #else
    #  redirect_to user_recording_path( @recording.user, @recording )
    #end

  end
  
  
private

  def recording_params
    params.require(:recording).permit!#( RecordingParams::PARAMS )
  end
end
  