class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  #def index
  #  @comments = Comment.all
  #end
  #
  ## GET /comments/1
  ## GET /comments/1.json
  #def show
  #end
  #
  ## GET /comments/new
  #def new
  #  @comment = Comment.new
  #end

  # GET /comments/1/edit
  def edit

  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if @comment.save!
      case @comment.commentable_type
      when 'Issue'
        
        redirect_to user_issue_path(@comment.user, @comment.commentable_id)
      end
    else
      redirect_to :back
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      case @comment.commentable_type
      when 'Issue'
        redirect_to user_issue_path(@comment.user, @comment.commentable_id)
      end
    else
      redirect_to :back
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    return_to = root_path
    case @comment.commentable_type
    when 'Issue'
      return_to  = user_issue_path(@comment.user, @comment.commentable_id)
    end
    @comment.destroy
    redirect_to return_to
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit!
    end
end
