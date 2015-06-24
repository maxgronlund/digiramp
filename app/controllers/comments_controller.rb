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
      
      #@comment.user.create_activity(  :created, 
      #                           owner: @comment, # the recording has many comments
      #                       recipient: @comment.commentable,
      #                  recipient_type: @comment.commentable_type,
      #                      account_id: @comment.user.account_id) 
      #                      
      #              
      case @comment.commentable_type
      
      when 'Issue'
        begin
          issue = Issue.cached_find(@comment.commentable_id)
          # send notification to issue owner
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
      when 'Recording'
        @recording = Recording.cached_find(@comment.commentable_id)
            
        current_user.create_activity(  :created, 
                                   owner: @comment, # the recording has many comments
                               recipient: @recording,
                          recipient_type: 'Recording',
                              account_id: @recording.user.account_id) 
        
        Activity.notify_followers(  'Posted a comment on', current_user.id, 'Recording', @recording.id )
        CommentMailer.delay.notify_user( @comment.id )
      when 'User'
        @user = User.cached_find(@comment.commentable_id)
            
        current_user.create_activity(  :created, 
                                   owner: @comment, # the recording has many comments
                               recipient: @user,
                          recipient_type: 'User',
                              account_id: @user.account_id) 
        
        Activity.notify_followers(  'Posted a comment on', current_user.id, 'User', @user.id )
        CommentMailer.delay.notify_user( @comment.id )

      else
        
      
      end
    else
      redirect_to :back
    end
    
    
  end
  
  #def post_on_social_media
  #  FbRecordingCommentWorker.perform_async(@comment.id)
  #end
  
 

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
    @hide_comment = "#comment_#{@comment.id}"
    case @comment.commentable_type
    when 'Issue'
      @comment.destroy
      redirect_to  = user_issue_path(@comment.user, @comment.commentable_id)

    else
      @comment.destroy
      
      #@comment.destroy
    end
    
    
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
