json.array!(@user_emails) do |user_email|
  json.extract! user_email, :id, :email, :user_id
  json.url user_email_url(user_email, format: :json)
end
