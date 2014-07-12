class Account::ProjectsController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = @account.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    forbidden unless current_account_user.update_crm
  end

  # POST /projects
  # POST /projects.json
  def create
    if @project = Project.create(project_params)
      redirect_to account_account_project_path(@account, @project)
    else
      redirect_to new_account_account_project_path(@account)
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to account_account_project_path(@account, @project)
    else
      redirect_to edit_account_account_project_path(@account, @project)
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    redirect_to account_account_projects_path(@account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:account_id, :user_id, :user_uuid, :title, :descriprion, :category, :stage)
    end
end
