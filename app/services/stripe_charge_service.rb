########################################################
# Stripe Charge CUD
########################################################

class StripeChargeService
  
  def subscribe events
    

    events.subscribe 'charge.dispute.created' do |event|
      ap '########################################################'
      ap 'charge.dispute.created'
      ap '########################################################'
      StripeMailer.admin_dispute_created(stripe_event: event.data.object).deliver_later
    end
    
  
    events.subscribe 'charge.succeeded' do |event|
      ap '########################################################'
      ap 'charge.succeeded'
      ap '########################################################'
      errored = true
      if stripe_data = event.data
        if stripe_object = stripe_data.object
          if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
            # finish transaction
            shop_order.finish!
            errored = false
          end
        end
      end
      if errored
        Opbeat.capture_message("charge.succeeded: #{event}")
      end
    end
  
    events.subscribe 'charge.failed' do |event|
      ap '########################################################'
      ap 'charge.failed'
      ap '########################################################'
      errored = true
      if stripe_data = event.data
        if stripe_object = stripe_data.object
          if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
            # finish transaction
            shop_order.error = stripe_object.failure_code
            shop_order.save
            shop_order.fail!
            errored = false
          end
        end
      end
      if errored
        Opbeat.capture_message("charge.failed: #{event}")
      end
    end
  
  
  end

end