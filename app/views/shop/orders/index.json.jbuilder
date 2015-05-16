json.array!(@shop_orders) do |shop_order|
  json.extract! shop_order, :id, :user_id, :stripe_customer_id
  json.url shop_order_url(shop_order, format: :json)
end
