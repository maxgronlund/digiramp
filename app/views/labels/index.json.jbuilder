json.array!(@labels) do |label|
  json.extract! label, :id, :title, :body, :image, :user_id, :account_id
  json.url label_url(label, format: :json)
end
