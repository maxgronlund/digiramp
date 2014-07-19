class Admin::VideosController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  respond_to :html, :xml, :json
  
  before_filter :find_video, only: [ :edit, :update, :destroy, :show]
  before_filter :admins_only
  
  def new
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video = @video_blog.videos.new

  end
  
  def show
    @video_blog = VideoBlog.find(params[:video_blog_id])

  end

  def edit
     @video_blog  = VideoBlog.find(params[:video_blog_id])

     
     
  end

  def create
    @video_blog = VideoBlog.find(params[:video_blog_id])
    results = TransloaditVideosParser.parse( params[:transloadit], nil, @video_blog.id)
    begin
      redirect_to admin_video_blog_video_path(@video_blog, results[:videos][0])
    rescue
      flash[:danger]   = { title: "Unable to create Video", body: results[:errors][0] }
      redirect_to new_admin_video_blog_video_path(@video_blog)
    end

  end

  def update
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video.update(video_params)
    
    #results = TransloaditVideosParser.update( params[:transloadit], nil, @video.id)

    
    redirect_to admin_video_blog_video_path(@video_blog, @video)

  end

  def destroy
    @video.destroy
    redirect_to admin_video_blog_path(@video.video_blog)
  end
  
  
  def sort
    params[:video].each_with_index do |id, index|
      Video.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
  
private
  def find_video
    @video = Video.find(params[:id])
  end
  
  def video_params
    params.require(:video).permit!
  end
  

end
