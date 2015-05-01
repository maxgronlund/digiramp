class Account::ProjectTasksController < ApplicationController
  include AccountsHelper
  before_action :access_account
  before_action :set_project_task, only: [:show, :edit, :update, :destroy]

  # GET /project_tasks
  # GET /project_tasks.json
  #def index
  #  @project_tasks = ProjectTask.all
  #end


  def show
    @user       = @account.user
    @authorized = true
  end

  # GET /project_tasks/new
  def new
    @project      = Project.cached_find(params[:project_id])
    @project_task = ProjectTask.new
    @user       = @account.user
    @authorized = true
  end

  # GET /project_tasks/1/edit
  def edit
    @project      = Project.cached_find(params[:project_id])
    @user       = @account.user
    @authorized = true
  end

  # POST /project_tasks
  # POST /project_tasks.json
  def create
    @project_task = ProjectTask.create(project_task_params)
    @project      = Project.cached_find(params[:project_id])
    redirect_to account_account_project_path(@account, @project)
  end

  # PATCH/PUT /project_tasks/1
  # PATCH/PUT /project_tasks/1.json
  def update
    @project      = Project.cached_find(params[:project_id])
    if @project_task.update!(project_task_params)
      redirect_to account_account_project_path(@account, @project)
    else
      redirect_to edit_account_account_project_project_task_path(@account, @project, @project_task)
    end
  end

  # DELETE /project_tasks/1
  # DELETE /project_tasks/1.json
  def destroy
    @project_task.destroy
    @project      = Project.cached_find(params[:project_id])
    redirect_to account_account_project_path(@account, @project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_task
      @project_task = ProjectTask.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_task_params
      params.require(:project_task).permit!
    end
end
