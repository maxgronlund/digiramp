########################################################
# Stripe Charge CUD
########################################################

class StripeChargeService
  
  def errored(error, obj)
    ap '-----------------------------'
    ap error
    ap obj
    
  end
  
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

      errored("Event: ", event)                         unless stripe_data            = event.data
      errored("Stripe object: ", stripe_data)           unless stripe_object          = stripe_data.object
      errored("Payment source", stripe_object.source)   unless stripe_payment_source  = stripe_object.source
      
      begin
        if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
          OrderPayment.set_address_fields_from_payment_source( shop_order, stripe_payment_source)
          shop_order.finish!
          InvoiceMailer.delay.send_confirmations( shop_order.id )
          
          shop_order.order_content[:payment_source] = JSON.parse(stripe_payment_source.to_json).deep_symbolize_keys 
          shop_order.order_content[:total_price]    = shop_order.total_price
          shop_order.create_transfers( stripe_object.id, stripe_object.amount )

          
          ShopOrderService.handle_downloabels(shop_order)
          shop_order.save(validate: false)
        else
          raise 'No order found'  
        end
      rescue => e
        errored('error', e )
      end
      
      
      
      
      
      #errored = true
      #if stripe_data = event.data
      #  if stripe_object = stripe_data.object
      #    if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
      #      # finish transaction
      #      shop_order.finish!
      #      errored = false
      #      
      #      InvoiceMailer.delay.send_confirmations( shop_order.id )
      #     
      #      if stripe_payment_source = stripe_object.source
      #        
      #        
      #        
      #        ap stripe_payment_source
      #        shop_order.order_content[:payment_source] = JSON.parse(stripe_payment_source.to_json).deep_symbolize_keys 
      #        shop_order.order_content[:total_price]    = shop_order.total_price
      #        shop_order.create_transfers( stripe_object.id, stripe_object.amount )
      #        #OrderPayment.set_address_fields_from_payment_source( stripe_payment_source)
      #        ShopOrderService.handle_downloabels(shop_order)
      #        shop_order.save(validate: false)
      #      end
      #    elsif subscription  = Subscription.find_by(stripe_id: stripe_object.id)
      #      
      #      ap subscription
      #      
      #      #subscription.finish!
      #      #errored           = false
      #      #account_type
      #    end
      #  end
      #end
      #if errored
      #  Opbeat.capture_message("charge.succeeded: #{event}")
      #end
    end
  
    events.subscribe 'charge.failed' do |event|
      ap '########################################################'
      ap 'charge.failed'
      ap '########################################################'
      errored             = true
      if stripe_data      = event.data
        if stripe_object  = stripe_data.object
          if shop_order   = Shop::Order.find_by(charge_id: stripe_object.id)
            # finish transaction
            shop_order.error = stripe_object.failure_code
            shop_order.save
            shop_order.fail!
            errored          = false
          elsif subscription = Subscription.find_by(stripe_id: stripe_object.id)
            subscription.fail!
            errored           = false
          end
        end
      end
      if errored
        Opbeat.capture_message("charge.failed", event: event)
      end
    end
  
  
  end

end