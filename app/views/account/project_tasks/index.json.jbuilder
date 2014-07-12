json.array!(@project_tasks) do |project_task|
  json.extract! project_task, :id, :project, :user_id, :title, :assigned_to, :category, :status, :due_date, :start_date, :reminder, :priority, :description
  json.url project_task_url(project_task, format: :json)
end
