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
  def new
    #@comment = Comment.new
  end

  # GET /comments/1/edit
  def edit

  end

  # POST /comments
  # POST /comments.json
  def create

    if @comment = Comment.create!(comment_params)
      case @comment.commentable_type
      when 'Recording'
        redirect_to comment_append_comment_to_recording_path( @comment)
      when 'Issue'
        begin
          issue = Issue.cached_find(@comment.commentable_id)
          # send notification to issue owner
          #ap issue.user.email
          channel = 'digiramp_radio_' + issue.user.email
          options = {  "channel" => channel, 
                       "title"   => 'Info', 
                       "message" => "Acomment is posted on the issue #{issue.title}", 
                       "time"    => '10000', 
                       "sticky"  => 'true', 
                       "image"   => 'notice'
                     }
          PusherWorker.perform_async(options)

        rescue
          puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
          puts 'ERROR: Unable send notification'
          puts 'In CommentController#create'
          puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
        end
        redirect_to user_issue_path(@comment.user, @comment.commentable_id)
      end
    else
      redirect_to :back
    end
  end
  
  def append_comment_to_recording
    
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
