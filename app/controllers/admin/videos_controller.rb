class Admin::VideosController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :admin_only
  before_filter :find_video, only: [ :edit, :update, :destroy, :crop, :crop_update, :show]
  layout "core_admin"
  
  def new
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video = @video_blog.videos.new
    @bread_crumbs = [
         {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
         {path:"#{admin_video_blogs_path}", title: "Video collections", icon: "icon-home"},
         {path:"#{admin_video_blog_path(@video_blog)}", title: @video_blog.title, icon: "icon-home"}
     ]
  end
  
  def show
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @bread_crumbs = [
        {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
        {path:"#{admin_video_blogs_path}", title: "Video collections", icon: "icon-home"},
        {path:"#{admin_video_blog_path(@video_blog)}", title: @video_blog.title, icon: "icon-home"}
    ]
  end

  def edit
     @video_blog = VideoBlog.find(params[:video_blog_id])
     @bread_crumbs = [
         {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
         {path:"#{admin_video_blogs_path}", title: "Video collections", icon: "icon-home"},
         {path:"#{admin_video_blog_path(@video_blog)}", title: @video_blog.title, icon: "icon-home"}
     ]
  end

  def create
    @video_blog = VideoBlog.find(params[:video_blog_id])
    @video = @video_blog.videos.create(video_params)
    redirect_to admin_video_blog_video_path(@video.video_blog, @video)
    #if params[:video][:image]
    #  redirect_to crop_admin_video_blog_video_path(@video.video_blog, @video, :version =>:size_370x272)
    #else
    #  redirect_to edit_admin_video_blog_video_path(@video.video_blog, @video)
    #end
  end

  def update
    @video.update(video_params)
    redirect_to admin_video_blog_video_path(@video.video_blog, @video)
    #if params[:video][:image] && params[:video][:remove_image] != '1'
    #if params[:video][:image]
    #  redirect_to crop_admin_video_blog_video_path(@video.video_blog, @video, :version =>:size_370x272)
    #else
    #  redirect_to edit_admin_video_blog_path(@video.video_blog)
    #end
  end

  def destroy
    @video.destroy
    redirect_to edit_admin_video_blog_path(@video.video_blog)
  end
  
#  def crop
#    @crop_version = (params[:version] ||:size_370x272).to_sym
#    @video.get_crop_version! @crop_version
#    @version_geometry_width, @version_geometry_height = VideoUploader.version_dimensions[@crop_version]
#    render :layout => 'cropper'
#  end
#
#  def crop_update
#    @video.crop_x = params[:video]["crop_x"]
#    @video.crop_y = params[:video]["crop_y"]
#    @video.crop_h = params[:video]["crop_h"]
#    @video.crop_w = params[:video]["crop_w"]
#    @video.crop_version = params[:video]["crop_version"]
#    @video.save
#    redirect_to edit_admin_video_blog_video_path(@video.video_blog, @video)
#  end
  
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
    if can_edit?
      params.require(:video).permit!
    end
  end
  

end
