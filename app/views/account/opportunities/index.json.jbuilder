json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :title, :body, :kind, :budget, :deadline, :account_id
  json.url opportunity_url(opportunity, format: :json)
end
