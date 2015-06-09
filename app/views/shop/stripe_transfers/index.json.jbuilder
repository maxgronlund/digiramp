json.array!(@shop_stripe_transfers) do |shop_stripe_transfer|
  json.extract! shop_stripe_transfer, :id, :shop_order_item_id, :shop_order_id, :user_id, :split, :due_date
  json.url shop_stripe_transfer_url(shop_stripe_transfer, format: :json)
end
