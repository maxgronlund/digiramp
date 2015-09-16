class User::AcceptRecordingIpisController < ApplicationController
  before_action :access_user
  def update
    @recording_ipi = RecordingIpi.cached_find(params[:id])
    @recording_ipi.accepted!
    redirect_to user_user_recording_ipi_path(@user, @recording_ipi)
  end
end