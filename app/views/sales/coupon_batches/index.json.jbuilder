json.array!(@sales_coupon_batches) do |sales_coupon_batch|
  json.extract! sales_coupon_batch, :id, :title, :body, :email, :created_by
  json.url sales_coupon_batch_url(sales_coupon_batch, format: :json)
end
