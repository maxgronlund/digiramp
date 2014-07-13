json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :account_id, :user_id, :title, :from_email, :from_title, :mail_layout_id, :subscription_message, :send
  json.url campaign_url(campaign, format: :json)
end
