json.array!(@forum_posts) do |forum_post|
  json.extract! forum_post, :id, :title, :body, :image, :user_id, :forum_id, :uniq_likes, :published
  json.url forum_post_url(forum_post, format: :json)
end
