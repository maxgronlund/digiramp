class ShareOnTwittersController < ApplicationController
 

 
  def create
    #ap params
    @share_on_twitter = ShareOnTwitter.create(share_on_twitter_params)
    @user = User.find(params[:share_on_twitter][:user_id])
    
    #ap @share_on_twitter.recording

    if @user.authorization_providers && @share_on_twitter
       
      # get twitter provider
      if provider_twitter = @user.authorization_providers.where(provider: 'twitter').first
          #ap provider_twitter[:oauth_token]
          #ap provider_twitter[:oauth_secret]
          client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV['TWITTER_KEY'] 
            config.consumer_secret     = ENV['TWITTER_SECRET'] 
            
            config.access_token        = provider_twitter[:oauth_token]
            config.access_token_secret = provider_twitter[:oauth_secret]

          end
    
          #client.update(@share_on_twitter.message)
          #client.update_with_media(@share_on_twitter.message, File.new(@share_on_twitter.recording.get_artwork))
          client.update_with_media(@share_on_twitter.message, File.new(@share_on_twitter.recording.get_cover_art), :possibly_sensitive => true)
      end
    end
    
    
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