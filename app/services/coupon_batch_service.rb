module CouponBatchService
  
  def self.call params, coupon_batch_id
    coupon_params =  params[:sales_coupon_batch]


    coupon_params[:number_of_coupons].to_i.times do
      coupon                            = Coupon.new
      coupon.stripe_id                  = get_uniq_stripe_id( coupon_params[:title] )
      coupon.amount_off                 = coupon_params[:amount_off] 
      coupon.percent_off                = coupon_params[:percent_off] 
      coupon.duration                   = coupon_params[:duration] 
      coupon.duration_in_months         = coupon_params[:duration_in_months] 
      coupon.max_redemptions            = 1
      coupon.currency                   = coupon_params[:currency] 
      coupon.redeem_by                  = coupon_params[:redeem_by] 
      coupon.plan_id                    = coupon_params[:plan_id] 
      coupon.coupon_batch_id            = coupon_batch_id
      coupon.save
    end
    
    calculate_total_price coupon_params, coupon_batch_id
  end
  
  def self.get_uniq_stripe_id title
    stripe_id = (title.gsub(' ', '-').upcase + '-' + SecureRandom.base64(4).upcase).gsub('=', '')
    if Coupon.exists?(stripe_id: stripe_id )
      get_uniq_stripe_id title
    end
    stripe_id
  end
  
  def self.calculate_total_price params, coupon_batch_id
    
    if plan          = Plan.find( params[:plan_id] )
      if coupon_batch  = Sales::CouponBatch.find(coupon_batch_id)
        
        discount         = (100 - coupon_batch.discount) * 0.01
        
        count = params[:duration] == 'repeating' ? params[:duration_in_months].to_i : 1
        units = coupon_batch.coupons.count * count
        price = plan.amount * units
        
        coupon_batch.original_price     = price
        coupon_batch.total_price        = price * discount
        coupon_batch.save(validate: false)
      end
    end

  end
  

end