class Account::ProjectTasksController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  before_action :set_project_task, only: [:show, :edit, :update, :destroy]

  # GET /project_tasks
  # GET /project_tasks.json
  def index
    @project_tasks = ProjectTask.all
  end

  # GET /project_tasks/1
  # GET /project_tasks/1.json
  def show
  end

  # GET /project_tasks/new
  def new
    @project      = Project.cached_find(params[:project_id])
    @project_task = ProjectTask.new
  end

  # GET /project_tasks/1/edit
  def edit
  end

  # POST /project_tasks
  # POST /project_tasks.json
  def create
    @project_task = ProjectTask.create(project_task_params)
    @project      = Project.cached_find(params[:project_id])
    redirect_to account_account_project_project_task_path(@account, @project, @project_task)
  end

  # PATCH/PUT /project_tasks/1
  # PATCH/PUT /project_tasks/1.json
  def update
    respond_to do |format|
      if @project_task.update(project_task_params)
        format.html { redirect_to @project_task, notice: 'Project task was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_task }
      else
        format.html { render :edit }
        format.json { render json: @project_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_tasks/1
  # DELETE /project_tasks/1.json
  def destroy
    @project_task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url, notice: 'Project task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_task
      @project_task = ProjectTask.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_task_params
      params.require(:project_task).permit(:project, :user_id, :title, :assigned_to, :category, :status, :due_date, :start_date, :reminder, :priority, :description)
    end
end
