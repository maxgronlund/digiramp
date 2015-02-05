class RepliesController < ApplicationController
  before_action :set_reply, only: [:update, :destroy, :edit]
  
  def create
    @reply = Reply.create(reply_params)
    @forum_post = ForumPost.find(@reply.replyable_id)
    
    redirect_to forum_post_path(@forum_post)
  end

  def update
    @reply.update(reply_params)
    @forum_post = ForumPost.find(@reply.replyable_id)
    redirect_to forum_post_path(@forum_post)
    
  end

  def destroy
    @reply_id = @reply.id
    @reply.destroy
  end
  
  def edit
    @user = current_user
  end
  
  private

  
  def set_reply
    @reply = Reply.cached_find(params[:id])
    
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def reply_params
    params.require(:reply).permit!
  end
  
end