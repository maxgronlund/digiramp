class TwitterRecordingTweetWorker
  include Sidekiq::Worker
  
  def perform share_on_twitter_id
    
    
    share_on_twitter = ShareOnTwitter.cached_find(share_on_twitter_id)
    user             = share_on_twitter.user
    
    if provider_twitter = user.authorization_providers.where(provider: 'twitter').first
    
      begin
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = Rails.application.secrets.twitter_app_id
          config.consumer_secret     = Rails.application.secrets.twitter_secret_key
          config.access_token        = provider_twitter[:oauth_token]
          config.access_token_secret = provider_twitter[:oauth_secret]
        end

        media_url = share_on_twitter.recording.get_artwork
        media     = open(media_url)
 
        if media.is_a?(StringIO)
          ext   = File.extname(media_url)
          name  = File.basename(media_url, ext)
          tf    = Tempfile.new([name, ext], Rails.root.join('tmp'))
          tf.binmode
          tf.write(media.read)
          tf.rewind
          client.update_with_media(share_on_twitter.message, tf)
          tf.close
          tf.unlink
        else
          client.update_with_media(share_on_twitter.message, media)
          media.close
        end
       
      rescue => e #Twitter::Error => e
        #e.inspect
        Opbeat.capture_message(e.inspect)
      end
    else
      # link user here
      # 'no provider'
    end
    
  end

end