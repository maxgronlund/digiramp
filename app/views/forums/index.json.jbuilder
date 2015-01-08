json.array!(@forums) do |forum|
  json.extract! forum, :id, :title, :body, :image, :user_id, :public_forum
  json.url forum_url(forum, format: :json)
end
