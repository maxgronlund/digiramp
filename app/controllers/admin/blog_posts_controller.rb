class Admin::BlogPostsController < ApplicationController
  
  before_filter :admins_only
  before_filter :find_blog_post, only: [ :edit, :update, :destroy, :crop, :crop_update, :show]

  
  def new
    @blog = Blog.find(params[:blog_id])
    @blog_post = @blog.blog_posts.new
    respond_with(:admin, @blog_post)
  end

  def edit
     @blog = Blog.find(params[:blog_id])

  end
  
  def show
     @blog = Blog.find(params[:blog_id])
     render :layout => 'clean_canvas'
  end

  def create
    @blog = Blog.find(params[:blog_id])
    if @blog_post = @blog.blog_posts.create(blog_post_params)
      #if params[:blog_post][:image]
      #  redirect_to crop_admin_blog_blog_post_path(@blog_post.blog, @blog_post, :version => :size_62x62)
      #else
        redirect_to admin_blog_path(@blog_post.blog)
        #end
    else

      render :new
    end
  end

  def update
    @blog = Blog.find(params[:blog_id])
    if @blog_post.update(blog_post_params)
    #if params[:blog_post][:image] && params[:blog_post][:remove_image] != '1'
      #if params[:blog_post][:image]
      #  redirect_to crop_admin_blog_blog_post_path(@blog_post.blog, @blog_post, :version => :size_62x62)
      #else
        flash[:info] = { title: "Success", body: "#{@blog_post.title}  updated" }
        redirect_to_return_url admin_blog_path(@blog_post.blog)
        #end
    else

      render :edit
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_path(@blog_post.blog)
  end
  
  def crop
    @crop_version = (params[:version] || :size_370x272).to_sym
    @blog_post.get_crop_version! @crop_version
    @version_geometry_width, @version_geometry_height = ArtworkUploader.version_dimensions[@crop_version]
    render :layout => 'cropper'
  end

  def crop_update
    @blog_post.crop_x = params[:blog_post]["crop_x"]
    @blog_post.crop_y = params[:blog_post]["crop_y"]
    @blog_post.crop_h = params[:blog_post]["crop_h"]
    @blog_post.crop_w = params[:blog_post]["crop_w"]
    @blog_post.crop_version = params[:blog_post]["crop_version"]
    @blog_post.save
    redirect_to_return_url admin_blog_path(@blog_post.blog)
    
  end
  
  def sort
    params[:blog_post].each_with_index do |id, index|
      BlogPost.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
  
private
  def find_blog_post
    @blog_post = BlogPost.find(params[:id])
  end
  
  def blog_post_params
    params.require(:blog_post).permit! if current_user.can_edit?
  end


end
