########################################################
# Stripe Customer CUD
########################################################

module StripeCustomerService
  
  def self.subscribe events
    
    events.subscribe 'customer.created' do |event|
      ap '########################################################'
      ap 'customer.created'
      ap '########################################################'

      if data = event.data
        if stripe_object = data.object
          StripeCustomer.where(stripe_id: stripe_object.id)
                        .first_or_create( stripe_id:        stripe_object.id,              
                                          stripe_object:    stripe_object.object,          
                                          created:          stripe_object.created.nil? ?        nil : Date.strptime(stripe_object.created.to_s, '%s'), 
                                          livemode:         stripe_object.livemode,
                                          description:      stripe_object.description,
                                          email:            stripe_object.email,
                                          delinquent:       stripe_object.delinquent,
                                          metadata:         stripe_object.metadata.nil? ?       nil : JSON.parse(stripe_object.metadata.to_json).deep_symbolize_keys,
                                          subscriptions:    stripe_object.subscriptions.nil? ?  nil : JSON.parse(stripe_object.subscriptions.to_json).deep_symbolize_keys,  # an array of hashes
                                          discount:         stripe_object.discount.nil? ?       nil : JSON.parse(stripe_object.discount.to_json).deep_symbolize_keys,
                                          account_balance:  stripe_object.account_balance,
                                          currency:         stripe_object.currency,
                                          sources:          stripe_object.sources.nil? ?        nil : JSON.parse(stripe_object.sources.to_json).deep_symbolize_keys,
                                          default_source:   stripe_object.default_source
                        )

        end
      end
    end

    events.subscribe 'customer.updated' do |event|
      ap '########################################################'
      ap 'customer.updated'
      ap '########################################################'
      digiramp_user         = nil
      digiramp_subscription = nil
      if data = event.data
        if stripe_object = data.object
          if stripe_customer = StripeCustomer.find_by(stripe_id: stripe_object.id)
          
            stripe_customer.livemode                = stripe_object.livemode,
            stripe_customer.description             = stripe_object.description,
            stripe_customer.email                   = stripe_object.email,
            stripe_customer.delinquent              = stripe_object.delinquent,
            stripe_customer.metadata                = stripe_object.metadata.nil? ?       nil : JSON.parse(stripe_object.metadata.to_json).deep_symbolize_keys,
            stripe_customer.subscriptions           = stripe_object.subscriptions.nil? ?  nil : JSON.parse(stripe_object.subscriptions.to_json).deep_symbolize_keys,  # an array of hashes
            stripe_customer.discount                = stripe_object.discount.nil? ?       nil : JSON.parse(stripe_object.discount.to_json).deep_symbolize_keys,
            stripe_customer.account_balance         = stripe_object.account_balance,
            stripe_customer.currency                = stripe_object.currency,
            stripe_customer.sources                 = stripe_object.sources.nil? ?        nil : JSON.parse(stripe_object.sources.to_json).deep_symbolize_keys,
            stripe_customer.default_source          = stripe_object.default_source
            stripe_customer.save
          end
        end
      end
    end
  
  
    events.subscribe 'customer.deleted' do |event|
      ap '########################################################'
      ap 'customer.deleted'
      ap '########################################################'
      if data = event.data
        if stripe_object = data.object
          if stripe_customer = StripeCustomer.find_by(stripe_id: stripe_object.id)
            ap 'stripe_customer found'
            stripe_customer.destroy
          end
        
          if user = User.find_by(stripe_customer_id: stripe_object.id )
            user.stripe_customer_id = nil
            user.save!
            PaymentSource.where(customer: stripe_object.id).destroy_all
          end
        
        end
      end
    end
  end
  

end