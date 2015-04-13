class User::CreativeProjectResourcesController < ApplicationController
  before_action :set_creative_project_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_creative_project_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # GET /creative_project_resources
  # GET /creative_project_resources.json
  def index
    
    @creative_project_resources = @creative_project.creative_project_resources
  end

  # GET /creative_project_resources/1
  # GET /creative_project_resources/1.json
  def show
  end

  # GET /creative_project_resources/new
  def new
    @creative_project_resource  = CreativeProjectResource.new
  end

  # GET /creative_project_resources/1/edit
  def edit
  end

  # POST /creative_project_resources
  # POST /creative_project_resources.json
  def create
    #@user                       = User.cached_find(params[:user_id])
    #@creative_project           = CreativeProject.cached_find(params[:creative_project_id])
    
    @creative_project_resource = CreativeProjectResource.new(creative_project_resource_params)
    if @creative_project_resource.save!
      redirect_to user_user_creative_project_creative_project_resources_path(@user, @creative_project)
    else
      redirect_to new_user_user_creative_project_creative_project_resource_path(@user, @creative_project)
    end
    #respond_to do |format|
    #  if @creative_project_resource.save
    #    format.html { redirect_to @creative_project_resource, notice: 'Creative project resource was successfully created.' }
    #    format.json { render :show, status: :created, location: @creative_project_resource }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @creative_project_resource.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /creative_project_resources/1
  # PATCH/PUT /creative_project_resources/1.json
  def update
    if @creative_project_resource.update(creative_project_resource_params)
      redirect_to user_user_creative_project_creative_project_resources_path(@user, @creative_project)
    else
      redirect_to new_user_user_creative_project_creative_project_resource_path(@user, @creative_project)
    end

  end

  # DELETE /creative_project_resources/1
  # DELETE /creative_project_resources/1.json
  def destroy
    @creative_project_resource.destroy
    
    redirect_to user_user_creative_project_creative_project_resources_path(@user, @creative_project)
    #respond_to do |format|
    #  format.html { redirect_to creative_project_resources_url, notice: 'Creative project resource was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creative_project_resource
      @creative_project_resource = CreativeProjectResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creative_project_resource_params
      params.require(:creative_project_resource).permit!
    end
    
    def set_creative_project_user
      @user                       = User.cached_find(params[:user_id])
      @creative_project           = CreativeProject.cached_find(params[:creative_project_id])
      @creative_project_user      = CreativeProjectUser.where(creative_project_id: @creative_project.id, user_id: current_user.id).first
      

    end
end
