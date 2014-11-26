class RecordingPlaybacksController < ApplicationController
  def show
    @user = User.friendly.find(params[:user_id])
    @recording = Recording.cached_find(params[:id])
    @authorized = false
    
    if current_user
      @authorized = true if current_user.id == @user.id
      @authorized = true if current_user.super?
    end

    ap @recording
  end
end
