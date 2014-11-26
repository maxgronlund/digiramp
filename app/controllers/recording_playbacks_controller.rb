class RecordingPlaybacksController < ApplicationController
  def show
    
    
    @user           = User.friendly.find(params[:user_id])
    @recording      = Recording.cached_find(params[:id])
    @authorized     = false
    
    if current_user
      @authorized = true if current_user.id == @user.id
      @authorized = true if current_user.super?
    end
    
    if user_ids =  Playback.where(recording_id: @recording.id).pluck(:user_id)
      user_ids.uniq!
      @users = User.find(user_ids)
    end
    
  end
end
