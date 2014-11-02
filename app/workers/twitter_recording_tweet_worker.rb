class TwitterRecordingTweetWorker
  include Sidekiq::Worker
  
  def perform comment_id
    if share_on_twitter = ShareOnTwitter.cached_find(comment_id)
      
      user      = share_on_twitter.user
      recording = share_on_twitter.recording
      
      user.tweet share_on_twitter.massage
      
      #if user.facebook_publish_actions
      #   user.facebook.put_wall_post(share_on_facebook.message,
      #                                {
      #                                "name" => "#{recording.title}",
      #                                "link" => "http://www.digiramp.com/users/#{recording.user.slug}/recordings/#{recording.id}",
      #                                "caption" => "#{user.name} posted a new review",
      #                                "description" => "#{recording.comment}",
      #                                "picture" => "#{recording.artwork}"
      #                              })
      #end
    end
  end

end