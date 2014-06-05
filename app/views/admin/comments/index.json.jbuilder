json.array!(@comments) do |comment|
  json.extract! comment, :id, :title, :body, :user_id, :image
  json.url comment_url(comment, format: :json)
end
