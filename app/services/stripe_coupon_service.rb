########################################################
# Stripe Customer CUD
########################################################

class StripeCouponService
  
  def subscribe events
    
    ########################################################
    # Coupons CUD
    ########################################################
  
    events.subscribe 'coupon.created' do |event|
      ap '########################################################'
      ap 'coupon.created'
      ap '########################################################'
      if data = event.data
        if object = data.object

          coupon = Coupon.where(stripe_id: object.id)
                         .first_or_create(stripe_id: object.id)
                         
          coupon.percent_off         = object.percent_off
          coupon.amount_off          = object.amount_off
          coupon.currency            = object.currency
          coupon.duration            = object.duration
          coupon.redeem_by           = object.redeem_by.nil? ? nil : Date.strptime(object.redeem_by.to_s, '%s')
          coupon.max_redemptions     = object.max_redemptions
          coupon.times_redeemed      = object.times_redeemed
          coupon.duration_in_months  = object.duration_in_months
          coupon.metadata            = JSON.parse(object.metadata.to_json).deep_symbolize_keys 
          coupon.stripe_object       = JSON.parse(object.to_json).deep_symbolize_keys
          coupon.save!
          coupon.push_to_stripe
        
        end
      end
    end
  
    events.subscribe 'coupon.deleted' do |event|
      ap '########################################################'
      ap 'coupon.deleted'
      ap '########################################################'
      if data = event.data
        if object = data.object
          stripe_id = object.id
          if coupon = Coupon.where(stripe_id: stripe_id).first
            coupon.destroy
          end
        end
      end
    end
  end

end