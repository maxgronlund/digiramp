class ShareRecordingWithEmailsController < ApplicationController
  
  def create
    @share_recording_with_email = ShareRecordingWithEmail.create(share_recording_with_email_params)
    @recording_id = params[:share_recording_with_email][:recording_id]
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def share_recording_with_email_params
      params.require(:share_recording_with_email).permit(:user_id, :recording_id, :recipients, :title, :message)
    end
end
