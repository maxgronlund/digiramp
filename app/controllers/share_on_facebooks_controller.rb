class ShareOnFacebooksController < ApplicationController

  
  def create
    @recording  = Recording.cached_find(params[:share_on_facebook][:recording_id])
    @user       = User.cached_find(params[:share_on_facebook][:user_id])
    @recording_id = @recording.id
    @share_on_facebook = ShareOnFacebook.new(share_on_facebook_params)
    if @share_on_facebook.save
      
      FbRecordingCommentWorker.perform_async(@share_on_facebook.id)
    end
    
    
    # also add a comment
    # Parameters: {"utf8"=>"✓", "comment"=>{"commentable_id"=>"1327", "commentable_type"=>"Recording", "user_id"=>"1", "body"=>"fobar\r\n"}, "commit"=>"Post"}
    if @comment = Comment.create!(commentable_id: @recording.id, commentable_type: "Recording", user_id: @user.id, body: @share_on_facebook.message )
      
     @comment.user.create_activity(  :created, 
                        owner: @comment,
                    recipient: @comment.commentable,
               recipient_type: @comment.commentable.class.name,
                   account_id: @comment.user.account_id)
    end 
  end

 

private
  def share_on_facebook_params
    params.require(:share_on_facebook).permit(:user_id, :recording_id, :message)
  end
end
