class FollowerEventsController < ApplicationController
  #before_filter :get_user
  
  def destroy
    follower_event =  FollowerEvent.cached_find(params[:wall_post_id])
    @follower_event_id = follower_event.id
    follower_event.destroy
  end
end
