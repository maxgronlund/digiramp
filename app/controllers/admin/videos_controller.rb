class Admin::VideosController < ApplicationController
  respond_to :html, :xml, :json
  
  before_filter :find_video, only: [ :edit, :update, :destroy, :crop, :crop_update, :show]

  
  def new
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video = @video_blog.videos.new

  end
  
  def show
    @video_blog = VideoBlog.find(params[:video_blog_id])

  end

  def edit
     @video_blog = VideoBlog.find(params[:video_blog_id])
  end

  def create
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video = @video_blog.videos.create(video_params)
    redirect_to admin_video_blog_video_path(@video.video_blog, @video)

  end

  def update
    @video.update(video_params)
    redirect_to admin_video_blog_path(@video.video_blog)

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
