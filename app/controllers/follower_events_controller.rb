class FollowerEventsController < ApplicationController
  #before_filter :get_user
  
  def destroy
    
    ap params
    follower_event =  FollowerEvent.cached_find(params[:id])
    @follower_event_id = follower_event.id
    follower_event.destroy
  end
end
