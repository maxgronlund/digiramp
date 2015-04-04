class Confirmation::WrongRecordingUsersController < ApplicationController
  def show
    not_found unless @recording_ipi  = RecordingIpi.where(uuid: params[:uuid]).first 
    not_found unless @user           = current_user
    
  end
end
