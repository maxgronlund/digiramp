require "open-uri"

class ShareOnTwittersController < ApplicationController
 

 
  def create

    @share_on_twitter = ShareOnTwitter.create(share_on_twitter_params)
    #@user             = User.find(params[:share_on_twitter][:user_id])
    @recording_id     = params[:share_on_twitter][:recording_id]
    
    TwitterRecordingTweetWorker.perform_async( @share_on_twitter.id)

  end
  
  def show
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_on_twitter
      @share_on_twitter = ShareOnTwitter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_on_twitter_params
      params.require(:share_on_twitter).permit!
    end
end


#client.update_with_media("I'm tweeting with @gem!", File.new("/path/to/sensitive-media.png"), :possibly_sensitive => true)