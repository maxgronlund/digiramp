class User::RecordingConfirmationsController < ApplicationController
  
  def new
    
    
    @user                   = User.cached_find(params[:user_id])
    @recording              = Recording.cached_find(params[:recording_id])
    @recording_ipi          = RecordingIpi.cached_find(params[:recording_ipi_id])
    @recording_ipi.title    = "Please confirm your rights on #{@recording.title}"
    @recording_ipi.message  = "Hi \nI would like you to confirm you credits share and rights on #{@recording.title} as:\n#{@recording_ipi.role} \n\n--#{@user.user_name}"


  end
end
