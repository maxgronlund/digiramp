json.array!(@features) do |feature|
  json.extract! feature, :id, :title, :body, :video1_id, :video2_id, :video3_id, :video4_id, :video5_id
  json.url feature_url(feature, format: :json)
end
