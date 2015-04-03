class User::RecordingIpisController < ApplicationController
  
  def update
    
    ap params[:commit]
    @user                         = User.cached_find(params[:user_id])
    @recording                    = Recording.cached_find(params[:recording_id])
    @recording_ipi                = RecordingIpi.cached_find(params[:id])
    @recording_ipi.confirmation   = 'Pending'
    @recording_ipi.save!
    if @recording_ipi.update(recording_ipi_params)
      @recording_ipi.send_confirmation_request 
    end
  end
  
  
  
private

  def recording_ipi_params
    params.require(:recording_ipi).permit!
  end
end
