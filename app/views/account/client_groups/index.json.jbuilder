json.array!(@client_groups) do |client_group|
  json.extract! client_group, :id, :title, :account_id
  json.url client_group_url(client_group, format: :json)
end
