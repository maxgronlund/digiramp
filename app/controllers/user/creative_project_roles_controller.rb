class User::CreativeProjectRolesController < ApplicationController
  
  before_action :set_creative_project_role, only: [ :show, :edit, :update, :destroy]
  before_action :access_user, except: [:index]
  
  before_action  :permit_creative_project_user

  def index
    @user                   = User.cached_find(params[:user_id])
    @creative_project       = CreativeProject.cached_find(params[:creative_project_id])
    @creative_project_roles = @creative_project.creative_project_roles
  end

  def show
  end

  def new
    @creative_project       = CreativeProject.cached_find(params[:creative_project_id])
    @creative_project_role  = CreativeProjectRole.new(role: params[:role])
  end

  def edit
    @creative_project       = CreativeProject.cached_find(params[:creative_project_id])
  end


  def create
    @creative_project       = CreativeProject.cached_find(params[:creative_project_id])
    @creative_project_role = CreativeProjectRole.new(creative_project_role_params)
    
    if @creative_project_role.save!
       @creative_project.update_looking_for
      redirect_to user_user_creative_project_creative_project_roles_path(@user, @creative_project)
    else
      redirect_to new_user_user_creative_project_creative_project_role_path(@user, @creative_project)
    end

  end

  def update
    if @creative_project_role.update(creative_project_role_params)
       @creative_project.update_looking_for
      redirect_to user_user_creative_project_creative_project_roles_path(@user, @creative_project)
    else
      redirect_to user_user_creative_project_creative_project_role_path(@user, @creative_project, @creative_project_role)
    end
    #respond_to do |format|
    #  if @creative_project_user.update(creative_project_user_params)
    #    format.html { redirect_to @creative_project_user, notice: 'Creative project user was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @creative_project_user }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @creative_project_user.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  def destroy
    @creative_project_role.destroy
    @creative_project.update_looking_for
    redirect_to user_user_creative_project_creative_project_roles_path(@user, @creative_project)
  end

  private
      

    def set_creative_project_role
      @creative_project       = CreativeProject.cached_find(params[:creative_project_id])
      @creative_project_role = CreativeProjectRole.cached_find(params[:id])
    end


    def creative_project_role_params
      params.require(:creative_project_role).permit!
    end
end
