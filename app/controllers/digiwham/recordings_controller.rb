class Digiwham::RecordingsController < ApplicationController
  
  # render the views for the playlist
  def index
    @widget     = Widget.where(secret_key: params[:key]).first
    ap @widget
    if @widget.catalog
      @recordings = @widget.catalog.recordings
    elsif @widget.playlist
      @recordings = @widget.playlist.recordings
    end
  end
  
  # the show function is used for count of playbacks
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
    widget = Widget.cached_find(params[:widget_id])
    widget.playback_count += 1
    widget.save!
    render nothing: true
  end

end
