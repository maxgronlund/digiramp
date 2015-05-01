class User::RecordingIpiInfosController < ApplicationController
  before_action :access_user
  def show
    @recording_ipi = RecordingIpi.cached_find(params[:id])
  end
end
