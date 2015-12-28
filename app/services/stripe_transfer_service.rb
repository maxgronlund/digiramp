########################################################
# Stripe Charge CUD
########################################################

class StripeTransferService
  
  include ErrorNotification
  
  def subscribe events

    events.subscribe 'transfer.paid' do |event|
      if Rails.env.development?
        ap '########################################################'
        ap 'transfer.paid'
        ap '########################################################'
      end
      errored = true
      if stripe_data = event.data
        ap stripe_data
        #if stripe_object = stripe_data.object
        #  if shop_order = Shop::Order.find_by(charge_id: stripe_object.id)
        #    # finish transaction
        #    shop_order.error = stripe_object.failure_code
        #    shop_order.save
        #    shop_order.fail!
        #    errored = false
        #  end
        #end
        errored = false
      end
      if errored
        Opbeat.capture_message("transfer.paid: #{event}")
      end
    end
  
  
    events.subscribe 'transfer.failed' do |event|
      if Rails.env.development?
        ap '########################################################'
        ap 'transfer.failed'
        ap '########################################################'
      end
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
        errored = false
      end
      if errored
        Opbeat.capture_message("transfer.failed: #{event}")
      end
    end
    
    
    events.subscribe 'transfer.created' do |event|
      if Rails.env.development?
        ap '########################################################'
        ap 'transfer.created'
        ap event
        ap '########################################################'
      end
      
      errored("Event: ", event)                       unless stripe_data           = event.data
      errored("Stripe object: ", stripe_data)         unless stripe_object         = stripe_data.object
      errored("Destination payment", stripe_object)   unless destination_payment   = stripe_object.destination_payment
      errored("source_transaction", stripe_object)    unless source_transaction    = stripe_object.source_transaction

      ap stripe_data
      
      begin
        
        if stripe_transfer = Shop::StripeTransfer.find_by(source_transaction: source_transaction)
          stripe_transfer.update_columns(destination_payment: destination_payment)
        else
          errored('StripeTransferService#transfer.created', 'transfer not found' )
        end
        
      rescue => e
        errored('StripeTransferService#transfer.created', e )
      end
    end
    
    
    
    
    
    
    events.subscribe 'transfer.reversed' do |event|
      if Rails.env.development?
        ap '########################################################'
        ap 'transfer.reversed'
        ap '########################################################'
      end
      
      errored("Event: ", event)                       unless stripe_data           = event.data
      errored("Stripe object: ", stripe_data)         unless stripe_object         = stripe_data.object
      errored("Destination payment", stripe_object)   unless destination_payment   = stripe_object.destination_payment
      errored("source_transaction", stripe_object)    unless source_transaction    = stripe_object.source_transaction

      
      
      begin
        
        if stripe_transfer = Shop::StripeTransfer.find_by(source_transaction: source_transaction)
          #stripe_transfer.update_columns(destination_payment: destination_payment)
        else
          errored('StripeTransferService#transfer.created', 'transfer not found' )
        end
        
      rescue => e
        errored('StripeTransferService#transfer.created', e )
      end
    end
    
    
  
  
  end

end