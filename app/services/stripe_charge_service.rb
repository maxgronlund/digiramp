########################################################
# Stripe Charge CUD
########################################################

class StripeChargeService
  
  include ErrorNotification
  #def errored(error, obj)
  #  message = "StripeChargeService #{error}: #{obj.inspect}"
  #  ap message
  #  Opbeat.capture_message( message )
  #end
  
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
        if order = Shop::Order.find_by(charge_id: stripe_object.id)
          OrderPayment.set_address_fields_from_payment_source( order, stripe_payment_source)
          
          order.order_content[:payment_source] = JSON.parse(stripe_payment_source.to_json).deep_symbolize_keys 
          order.order_content[:total_price]    = order.total_price
          
          

          order.charge_succeeded( stripe_object.id, stripe_object.amount )
          order.save(validate: false)
          order.finish!
          
          
          ShopOrderService.handle_downloabels(order)
          InvoiceMailer.delay.send_confirmations( order.id )
          
        else
          raise 'No order found'  
        end
      rescue => e
        errored('StripeChargeService#subscribe', e )
      end
      
      
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