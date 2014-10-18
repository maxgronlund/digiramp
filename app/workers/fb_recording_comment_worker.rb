class FbRecordingCommentWorker
  include Sidekiq::Worker
  
  def perform comment_id
    if comment = Comment.cached_find(comment_id)
      user = comment.user
      recording = comment.commentable
      if user.facebook_publish_actions
         user.facebook.put_wall_post(comment.body,
                                      {
                                      "name" => "#{recording.title}",
                                      "link" => "http://www.assets-manager.com/#{user.slug}recordings/#{recording.id}",
                                      "caption" => "#{user.name} posted a new review",
                                      "description" => "#{recording.comment}",
                                      "picture" => "#{recording.artwork}"
                                    })
         
         
         
                                     
         puts 'year posted'
      end
    end
  end

end