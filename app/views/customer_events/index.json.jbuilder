json.array!(@customer_events) do |customer_event|
  json.extract! customer_event, :id, :event_type, :action_type, :title, :body, :folow_up, :follow_up_date, :account_id, :customer_id
  json.url customer_event_url(customer_event, format: :json)
end
