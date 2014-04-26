json.array!(@video_posts) do |video_post|
  json.extract! video_post, :id, :title, :body, :mp4_video, :mp4_video_mobile, :webm_video
  json.url video_post_url(video_post, format: :json)
end
