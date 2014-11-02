class FbRecordingCommentWorker
  include Sidekiq::Worker
  
  def perform comment_id
    if share_on_facebook = ShareOnFacebook.cached_find(comment_id)
      
      user      = share_on_facebook.user
      recording = share_on_facebook.recording
      
      if user.facebook_publish_actions
         user.facebook.put_wall_post(share_on_facebook.message,
                                      {
                                      "name" => "#{recording.title}",
                                      "link" => "http://www.digiramp.com/users/#{recording.user.slug}/recordings/#{recording.id}",
                                      "caption" => "#{user.name} posted a new review",
                                      "description" => "#{recording.comment}",
                                      "picture" => "#{recording.artwork}"
                                    })
         
         
         
                                     
         # also add a comment
         # Parameters: {"utf8"=>"✓", "comment"=>{"commentable_id"=>"1327", "commentable_type"=>"Recording", "user_id"=>"1", "body"=>"fobar\r\n"}, "commit"=>"Post"}
         #if @comment = Comment.create!(commentable_id: recording.id, commentable_type: "Recording", user_id: user.id, body: recording.comment )
         #  
         # @comment.user.create_activity(  :created, 
         #                    owner: @comment,
         #                recipient: @comment.commentable,
         #           recipient_type: @comment.commentable.class.name,
         #               account_id: @comment.user.account_id)
         #end 
      end
    end
  end

end