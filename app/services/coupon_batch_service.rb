module CouponBatchService
  
  def self.call params, coupon_batches_id
    coupon_params =  params[:sales_coupon_batch]


    coupon_params[:number_of_coupons].to_i.times do
      coupon = Coupon.new
      coupon.stripe_id                  = get_uniq_stripe_id( coupon_params[:title] )
      coupon.amount_off                 = coupon_params[:amount_off] 
      coupon.percent_off                = coupon_params[:percent_off] 
      coupon.duration                   = coupon_params[:duration] 
      coupon.duration_in_months         = coupon_params[:duration_in_months] 
      coupon.max_redemptions            = 1
      coupon.currency                   = coupon_params[:currency] 
      coupon.redeem_by                  = coupon_params[:redeem_by] 
      coupon.plan_id                    = coupon_params[:plan_id] 
      coupon.sales_coupon_batch_id      = coupon_batches_id
      coupon.save
    end
  end
  
  def self.get_uniq_stripe_id title
    stripe_id = (title.gsub(' ', '-').upcase + '-' + SecureRandom.base64(4).upcase).gsub('=', '')
    if Coupon.exists?(stripe_id: stripe_id )
      get_uniq_stripe_id title
    end
    stripe_id
  end

end