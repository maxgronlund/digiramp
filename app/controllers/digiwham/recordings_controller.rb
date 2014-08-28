class Digiwham::RecordingsController < ApplicationController
  
  def index
    @widget     = Widget.where(secret_key: params[:key]).first
    @recordings = @widget.catalog.recordings
  end
  
  # count playbacks
  def show
    @recording                  = Recording.cached_find(params[:id])
    @recording.playbacks_count  += 1
    @recording.save!
    user_id                     = current_user ? current_user.id : nil
    Playback.create(
                      recording_id: @recording.id, 
                      user_id: user_id, 
                      account_id: @recording.account_id 
                    )
    render nothing: true
  end

end
