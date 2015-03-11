json.array!(@cms_user_activities) do |cms_user_activity|
  json.extract! cms_user_activity, :id, :user_id
  json.url cms_user_activity_url(cms_user_activity, format: :json)
end
