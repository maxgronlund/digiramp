json.array!(@mail_campaigns) do |mail_campaign|
  json.extract! mail_campaign, :id, :account_id, :user_id, :title, :from_email, :from_title, :mail_layout_id, :subscription_message
  json.url mail_campaign_url(mail_campaign, format: :json)
end
