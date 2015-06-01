class Admin::VideoBlogsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_action :admin_only
  before_action :find_video_blog, only: [:show, :edit, :update, :destroy]
  
  
  
  def index
    @video_blogs = VideoBlog.blog_search(params[:query]).order('title asc').page(params[:page]).per(12)
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
    redirect_to admin_video_blog_path( @video_blog )
  end

  def update
    @video_blog.update(video_blog_params)
    redirect_to admin_video_blog_path( @video_blog )
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
    params.require(:video_blog).permit!  if super?

  end

end