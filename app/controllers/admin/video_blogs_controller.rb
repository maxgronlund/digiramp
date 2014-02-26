class Admin::VideoBlogsController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :admin_only
  before_filter :find_video_blog, only: [:show, :edit, :update, :destroy]
  
  
  
  def index
    @video_blogs = VideoBlog.all

  end
  
  def show

  end

  def new
    @video_blog = VideoBlog.new

  end

  def edit

  end

  def create
    @video_blog = VideoBlog.new(video_blog_params)
    @video_blog.save
    redirect_to admin_video_blogs_path
  end

  def update
    @video_blog.update(video_blog_params)
    redirect_to admin_video_blogs_path
  end

  def destroy
    @video_blog.destroy
    redirect_to admin_video_blogs_path
  end
  
private
  def find_video_blog
    @video_blog = VideoBlog.find(params[:id])
  end

  def video_blog_params
    params.require(:video_blog).permit!  if current_user.can_edit?

  end

end