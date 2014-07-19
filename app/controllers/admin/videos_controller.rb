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
    
    results = TransloaditVideosParser.parse( params, nil, @video_blog.id)

    if results[:errors][0].to_s == 'No valid files uploaded'
      flash[:danger]   = { title: "Unable to create Video", body: results[:errors][0] }
      Video.create(video_params)
    end
    
    redirect_to admin_video_blog_path(@video_blog)

  end

  def update
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video.update(video_params)
    
    results = TransloaditVideosParser.update( params[:transloadit], @video)
    unless results[:errors][0].to_s == ''
      flash[:danger]   = { title: "Unable to update Video", body: results[:errors][0] }
    end
    redirect_to admin_video_blog_path(@video_blog)
    #redirect_to admin_video_blog_video_path(@video_blog, @video)

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
