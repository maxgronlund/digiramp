########################################################
# Stripe payment sources 
########################################################

class StripeCustomerSourceService
  
  def subscribe events
    
    ########################################################
    # Customer payment source CUD
    ########################################################
  
    events.subscribe 'customer.source.created' do |event|
      ap '########################################################'
      ap 'customer.source.created'
      ap '########################################################'
      if data = event.data
        if stripe_payment_source = data.object

          if user = User.find_by(stripe_customer_id: stripe_payment_source.customer)
        
            if digiramp_payment_source = PaymentSource.where(  stripe_id:    stripe_payment_source.id)
                                            .first_or_create(  stripe_id:    stripe_payment_source.id,
                                                               stripe_data:  JSON.parse(stripe_payment_source.to_json).deep_symbolize_keys,
                                                               customer:     stripe_payment_source.customer,
                                                               user_id:      user.id
                                                            )
            
            end
          end
        
        end
      end
    end
  
    events.subscribe 'customer.source.updated' do |event|
      ap '########################################################'
      ap 'customer.source.updated'
      ap '########################################################'
      if data = event.data
        if object = data.object
          if stripe_id = object.id
            if digiramp_payment_source            = PaymentSource.where(stripe_id: stripe_id).first
              digiramp_payment_source.stripe_data = JSON.parse(object.to_json).deep_symbolize_keys
              digiramp_payment_source.save
            end
          end
        end
      end
    end
  
    events.subscribe 'customer.source.deleted' do |event|
      ap '########################################################'
      ap 'customer.source.deleted'
      ap '########################################################'
      if data = event.data
        if object = data.object
          stripe_id = object.id
          if payment_source = PaymentSource.where(stripe_id: stripe_id).first
            payment_source.destroy
          end
        end
      end
    end
  end
    

end