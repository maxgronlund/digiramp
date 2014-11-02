json.array!(@share_on_twitters) do |share_on_twitter|
  json.extract! share_on_twitter, :id, :user_id, :recording_id, :message
  json.url share_on_twitter_url(share_on_twitter, format: :json)
end
