class RecordingPlaybacksController < ApplicationController
  def show
    @user = User.friendly.find(params[:user_id])
    @recording = Recording.cached_find(params[:id])
    @authorized = false
    
    if (current_user && current_user.id == @user.id) 
      @authorized = true
    end
    ap @recording
  end
end
