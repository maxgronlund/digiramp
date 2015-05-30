########################################################
# Stripe Charge CUD
########################################################

class StripeTransferService
  
  def subscribe events
    

    events.subscribe 'transfer.paid' do |event|
      ap '########################################################'
      ap 'transfer.paid'
      ap '########################################################'
      errored = true
      if stripe_data = event.data
        #if stripe_object = stripe_data.object
        #  if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
        #    # finish transaction
        #    shop_order.error = stripe_object.failure_code
        #    shop_order.save
        #    shop_order.fail!
        #    errored = false
        #  end
        #end
      end
      if errored
        Opbeat.capture_message("transfer.paid: #{event}")
      end
    end
  
  
    events.subscribe 'transfer.failed' do |event|
      ap '########################################################'
      ap 'transfer.failed'
      ap '########################################################'
      errored = true
      if stripe_data = event.data
        #if stripe_object = stripe_data.object
        #  if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
        #    # finish transaction
        #    shop_order.error = stripe_object.failure_code
        #    shop_order.save
        #    shop_order.fail!
        #    errored = false
        #  end
        #end
      end
      if errored
        Opbeat.capture_message("transfer.failed: #{event}")
      end
    end
  
  
  end

end