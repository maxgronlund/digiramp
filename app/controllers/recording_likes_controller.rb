class RecordingLikesController < ApplicationController
  before_action :get_user
  
  def index

    begin
      @recording    = Recording.cached_find(params[:recording_id])
      
      # !!! optimization needed
      # fetching all likes on each ajax request
      user_ids      = Like.where(recording_id: @recording.id).pluck(:user_id)
      @users        = User.where(id: user_ids).page(params[:page]).per(4)
      
      @show         = 'likes for a recording'
      @playlists    = current_user.playlists if current_user
    rescue
      not_found params: params, id: 'not_found'
    end
  end
    
end
