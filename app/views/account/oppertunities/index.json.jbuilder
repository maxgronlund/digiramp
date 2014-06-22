json.array!(@oppertunities) do |oppertunity|
  json.extract! oppertunity, :id, :title, :body, :kind, :budget, :deadline, :account_id
  json.url oppertunity_url(oppertunity, format: :json)
end
