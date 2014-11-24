class RecordingPlaybacksController < ApplicationController
  def show
    @user = User.friendly.find(params[:user_id])
    @recording = Recording.cached_find(params[:id])
    @authorized = false
    #@user = User.cached_find(params[:user_id])
    if (current_user && current_user.id == @user.id) || can_edit?
      @authorized = true
    end
    ap @recording
  end
end
