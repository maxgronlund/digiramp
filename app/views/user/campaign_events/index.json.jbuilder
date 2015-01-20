json.array!(@campaign_events) do |campaign_event|
  json.extract! campaign_event, :id, :campaign_id, :user_id, :account_id, :title, :body, :campaign_type, :status
  json.url campaign_event_url(campaign_event, format: :json)
end
