require "open-uri"

class ShareOnTwittersController < ApplicationController
 

 
  def create

    @share_on_twitter = ShareOnTwitter.create(share_on_twitter_params)
    @user             = User.find(params[:share_on_twitter][:user_id])
    @recording_id     = @share_on_twitter.recording.id

    if @user.authorization_providers && @share_on_twitter
       
      # get twitter provider
      if provider_twitter = @user.authorization_providers.where(provider: 'twitter').first

        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = TWITTER_KEY
          config.consumer_secret     = TWITTER_SECRET
          
          config.access_token        = provider_twitter[:oauth_token]
          config.access_token_secret = provider_twitter[:oauth_secret]
        
        end
        
        #client.update(@share_on_twitter.message)
        open(@share_on_twitter.recording.get_artwork) do |file|
          client.update_with_media(@share_on_twitter.message, file );
        end
      end
    end
    
    
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