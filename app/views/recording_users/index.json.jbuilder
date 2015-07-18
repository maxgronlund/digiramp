json.array!(@recording_users) do |recording_user|
  json.extract! recording_user, :id, :user_id, :recording_id, :email
  json.url recording_user_url(recording_user, format: :json)
end
