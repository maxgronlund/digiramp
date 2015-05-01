class User::CreativeProjectsController < ApplicationController
  before_action :set_creative_project, only: [:show, :edit, :update, :destroy]
  before_action :access_user, only: [:new, :create, :edit, :update, :destroy]
  
  #before_action  :permit_creative_project_user
  
  def index
    @user = User.cached_find(params[:user_id])
    
    if current_user && current_user.id == @user.id
      @creative_projects = @user.creative_projects
    else
      @creative_projects = @user.creative_projects.where(public_project: true)
    end
  end

  def show
    @user = User.cached_find(params[:user_id])
  end

  def new
    @creative_project = CreativeProject.new
  end

  def edit
  end

  def create
    
    @creative_project = CreativeProject.new(creative_project_params)
    
    
    if @creative_project.save!
      redirect_to user_user_creative_project_creative_project_roles_path( @user, @creative_project )
    else
      redirect_to new_user_user_creative_projects_path( @user )
    end

  end

  def update
    if @creative_project.update(creative_project_params)
      redirect_to user_user_creative_project_creative_project_dashboards_path( @user, @creative_project )
    else
      redirect_to edit_user_user_creative_project_path( @user, @creative_project )
    end

  end

  def destroy
    @creative_project.destroy!
    redirect_to user_user_creative_projects_path( @user )
  end

  private
    def set_creative_project
      @creative_project = CreativeProject.find(params[:id])
    end

    def creative_project_params
      params.require(:creative_project).permit!
    end
end
