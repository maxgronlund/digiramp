class FollowerEventsController < ApplicationController
  #before_action :get_user
  
  def destroy
    begin
      follower_event =  FollowerEvent.cached_find(params[:id])
      @follower_event_id = follower_event.id
      follower_event.destroy
    rescue => error
      ap 'FollowerEventsController'
      ap error.inspect
    end
  end
end
