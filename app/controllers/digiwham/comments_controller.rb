class Digiwham::CommentsController < ApplicationController


  
  def create
    @comment = Comment.create!(comment_params)
    @target_tag = ".recording_comments##{@comment.commentable_id}"
    @comment_partia = '<%=j render("digi_whams/fobar") %>'
  end
  
private


  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit!
  end

  
end