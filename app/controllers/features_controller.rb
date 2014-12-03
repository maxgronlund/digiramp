class FeaturesController < ApplicationController
  
  before_filter :access_user, only: [:create, :edit, :update, :new, :destroy]
  before_filter :feature_requests
  
  def index
    
  end

  def new
    @feature = Feature.new
  end

  def edit
  
  end

  def show
    @feature = BlogPost.find_by_id(params[:id])
  end
  
  def create

    params[:feature][:user_id]      = current_user.id
    params[:feature][:blog_id]      = @feature_requests.id
    params[:feature][:identifier]   = UUIDTools::UUID.timestamp_create().to_s
    feature = BlogPost.create(feature_params)

    redirect_to user_feature_requests_path(current_user)
    
  end
  
  
  # POST /comments
  # POST /comments.json
  def create_comment

    if @comment = Comment.create!(comment_params)

      feature = BlogPost.find_by_id(@comment.commentable_id)
      # send notification to issue owner

      channel = 'digiramp_radio_' + feature.user.email
      options = {  "channel" => channel, 
                   "title"   => 'Info', 
                   "message" => "Acomment is posted on the feature request #{feature.title}", 
                   "time"    => '10000', 
                   "sticky"  => 'true', 
                   "image"   => 'notice'
                 }
      PusherWorker.perform_async(options)
      

      redirect_to user_feature_requests_path(current_user)
        

    else
      redirect_to :back
    end
  end
  
  
  
  
private
  # Use callbacks to share common setup or constraints between actions.
  def feature_requests
    @feature_requests       = Blog.cached_find('USER FEATURE REQUESTS')
    
  end
  
  def feature identifier
    @feature  = BlogPost.cached_find( identifier , blog)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feature_params
    params.require(:feature).permit!
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit!
  end
  
end
  