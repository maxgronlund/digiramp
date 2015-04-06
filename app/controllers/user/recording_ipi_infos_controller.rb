class User::RecordingIpiInfosController < ApplicationController
  before_filter :access_user
  def show
    @recording_ipi = RecordingIpi.cached_find(params[:id])
  end
end
