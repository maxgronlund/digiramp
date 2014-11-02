class ShareOnTwittersController < ApplicationController
 

 
  def create
    ap params
    @share_on_twitter = ShareOnTwitter.new(share_on_twitter_params)
    @user = User.find(params[:share_on_twitter][:user_id])

    if @user.authorization_providers
       
      # get twitter provider
      if provider_twitter = @user.authorization_providers.where(provider: 'twitter').first
    
          client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV['TWITTER_KEY'] 
            config.consumer_secret     = ENV['TWITTER_SECRET'] 
            config.access_token        = "15994070-Jgnqxzf10LboGnXxeCP3y9Tevu9khqRmlvrKzZzmw"#provider_twitter[:oauth_token]
            config.access_token_secret = "hn0prX2igSGsXGD0shuIKl9nNMvKhtOXd3zDVlRxB98Jn"#provider_twitter[:oauth_secret]
          end
    
          client.update(message)
          #client.update("I'm tweeting with @gem!")
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
      params.require(:share_on_twitter).permit(:user_id, :recording_id, :message)
    end
end
