class User::AcceptRecordingIpisController < ApplicationController
  before_filter :access_user
  def update
    @recording_ipi = RecordingIpi.cached_find(params[:id])
    @recording_ipi.confirmation = 'Accepted'
    @recording_ipi.save!
    redirect_to user_user_recording_ipi_path(@user, @recording_ipi)
  end
end