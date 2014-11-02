class ShareOnFacebooksController < ApplicationController
  before_action :set_share_on_facebook, only: [:show, :edit, :update, :destroy]

  # GET /share_on_facebooks
  # GET /share_on_facebooks.json
  
  def create

    @recording  = Recording.cached_find(params[:share_on_facebook][:recording_id])
    @user       = User.cached_find(params[:share_on_facebook][:user_id])
    
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
    # Use callbacks to share common setup or constraints between actions.
    def set_share_on_facebook
      @share_on_facebook = ShareOnFacebook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_on_facebook_params
      params.require(:share_on_facebook).permit(:user_id, :recording_id, :message)
    end
end
