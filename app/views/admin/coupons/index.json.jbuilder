json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :percent_off, :duration, :duration_in_month, :stripe_id, :currency, :max_redemptions, :metadata, :redeem_by, :user_id, :account_id
  json.url coupon_url(coupon, format: :json)
end
