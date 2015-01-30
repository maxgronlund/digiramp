class TwitterRecordingTweetWorker
  include Sidekiq::Worker
  
  def perform share_on_twitter_id
    if share_on_twitter = ShareOnTwitter.cached_find(share_on_twitter_id)
      ap share_on_twitter
      if user = share_on_twitter.user
        user.tweet( share_on_twitter_id )
      else
        ap 'no user found'
      end
      
    else
      ap 'share on twitter not found'
    end
  end

end