class RepliesController < ApplicationController
  before_action :set_reply, only: [:update, :destroy]
  
  def create
    @reply = Reply.create(reply_params)
    @forum_post = ForumPost.find(@reply.replyable_id)
    
  end

  def update
  end

  def destroy
    @reply_id = @reply.id
    @reply.destroy
  end
  
  def edit
    
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