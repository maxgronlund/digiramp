json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :title, :body, :user_id, :account_id, :status, :emails
  json.url campaign_url(campaign, format: :json)
end
