class Admin::BlogsController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :admin_only
  before_filter :find_blog, only: [:edit, :update, :destroy, :show]
  #skip_before_filter :verify_authenticity_token, :only => [:destroy]
  #layout "core_admin"
  def index
    @blogs = Blog.all
    @bread_crumbs = [
        {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"}
    ]

  end
  
  def show
    @bread_crumbs = [
        {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
        {path:"#{admin_blogs_path}", title: "Blogs", icon: "icon-list"}
    ]
  end

  def new
    @blog = Blog.new
    @bread_crumbs = [
        {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
        {path:"#{admin_blogs_path}", title: "Blogs", icon: "icon-list"}
    ]
  end

  def edit
    @bread_crumbs = [
        {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
        {path:"#{admin_blogs_path}", title: "Blogs", icon: "icon-list"}
    ]
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:info] = { title: "Success", body: "#{@blog.title} Created" }
      redirect_to admin_blogs_path
    else
      @bread_crumbs = [
          {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
          {path:"#{admin_blogs_path}", title: "Blogs", icon: "icon-list"}
      ]
      render :new
    end
    
  end

  def update
    if @blog.update(blog_params)
      flash[:info] = { title: "Success", body: "#{@blog.title} updated" }
      redirect_to admin_blogs_path
    else
      @bread_crumbs = [
          {path:"#{admin_index_path}", title: "Digiramp Admin", icon: "icon-home"},
          {path:"#{admin_blogs_path}", title: "Blogs", icon: "icon-list"}
      ]
      render :edit
    end
    #redirect_to session[:go_to_after_update] || admin_blogs_path
  end

  def destroy
    flash[:info] = { title: "Success", body: "#{@blog.title} deleted" }
    @blog.destroy
    redirect_to admin_blogs_path
    #redirect_to admin_blogs_path
  end
  
private
  def find_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    if can_edit?
      params.require(:blog).permit!
    end
  end

end