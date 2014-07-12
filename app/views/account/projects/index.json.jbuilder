json.array!(@projects) do |project|
  json.extract! project, :id, :account_id, :user_id, :user_uuid, :title, :descriprion, :category, :stage
  json.url project_url(project, format: :json)
end
