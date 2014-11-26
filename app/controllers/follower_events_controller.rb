class FollowerEventsController < ApplicationController
  #before_filter :get_user
  
  def destroy
    @follower_event_id =  FollowerEvent.cached_find(params[:wall_post_id]).id
  end
end
