class Digiwham::RecordingsController < ApplicationController
  
  # render the views for the playlist
  def index
    begin
      @catalog_user = nil
      if params[:catalog]
        @catalog_user = CatalogUser.where(uuid: params[:catalog_user]).first
      end
      @widget     = Widget.where(secret_key: params[:key]).first
      @recordings = Recording.recordings_search( @widget.recordings, params[:query]) 
    rescue
      
    end

  end
  
  # the show function is used for count of playbacks
  def show
    puts '---------------------------- show --------------------------------------------'
    begin
      @recording                      = Recording.cached_find(params[:id])
      @recording.playbacks_count      += 1
      @recording.uniq_playbacks_count = Uniqifyer.uniqify(@recording.playbacks_count)
      @recording.save!
      user_id                     = current_user ? current_user.id : nil
      playback = Playback.create(
                        recording_id: @recording.id, 
                        user_id: user_id, 
                        account_id: @recording.account_id 
                      )
      
      
      if current_user                
        current_user.create_activity(  :created, 
                                   owner: playback, # the recording has many comments
                               recipient: @recording,
                          recipient_type: 'Recording',
                              account_id: @recording.user.account_id) 
      end
    rescue
    end
    #widget = Widget.cached_find(params[:widget_id])
    #widget.playback_count += 1
    #widget.save!
    render nothing: true
  end

end
