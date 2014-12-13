class Admin::ActivityCounterController < ApplicationController
  
  
  def show

    @recording             = Recording.cached_find(params[:id])
    @recording.create_activity(  :playback, 
                              owner: current_user,
                          recipient: @recording,
                     recipient_type: @recording.class.name,
                         account_id: @recording.account.id)
    render nothing: true
  end
end
