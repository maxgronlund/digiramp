require 'test_helper'

class ProjectTasksControllerTest < ActionController::TestCase
  setup do
    @project_task = project_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_task" do
    assert_difference('ProjectTask.count') do
      post :create, project_task: { assigned_to: @project_task.assigned_to, category: @project_task.category, description: @project_task.description, due_date: @project_task.due_date, priority: @project_task.priority, project_id: @project_task.project_id, reminder: @project_task.reminder, start_date: @project_task.start_date, status: @project_task.status, title: @project_task.title, user_id: @project_task.user_id }
    end

    assert_redirected_to project_task_path(assigns(:project_task))
  end

  test "should show project_task" do
    get :show, id: @project_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_task
    assert_response :success
  end

  test "should update project_task" do
    patch :update, id: @project_task, project_task: { assigned_to: @project_task.assigned_to, category: @project_task.category, description: @project_task.description, due_date: @project_task.due_date, priority: @project_task.priority, project_id: @project_task.project_id, reminder: @project_task.reminder, start_date: @project_task.start_date, status: @project_task.status, title: @project_task.title, user_id: @project_task.user_id }
    assert_redirected_to project_task_path(assigns(:project_task))
  end

  test "should destroy project_task" do
    assert_difference('ProjectTask.count', -1) do
      delete :destroy, id: @project_task
    end

    assert_redirected_to project_tasks_path
  end
end
