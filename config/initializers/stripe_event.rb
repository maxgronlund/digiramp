StripeEvent.event_retriever = lambda do |params|
  
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])

end

StripeEvent.configure do |events|
  
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
    if stripe_data = event.data
      if stripe_object = stripe_data.object
        
        # pull invoice from stripe and send it to the customer
        if user = User.find_by(stripe_customer_id: stripe_object.customer)
          ap Stripe::Invoice.retrieve(stripe_object.invoice)
        end
        
        #ap stripe_object
      end
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  ########################################################
  # customer.subscription CUD
  ########################################################
  
  events.subscribe 'customer.subscription.created' do |event|
    ap '########################################################'
    ap 'customer.subscription.created'
    ap '########################################################'
    if data = event.data
      if stripe_object = data.object

        if  subscription = Subscription.where(stripe_id: stripe_object.id)
                                       .first_or_create( stripe_id:  stripe_object.id)
                                       
          subscription.update!                             
          subscription.current_period_end        = Date.strptime(stripe_object.current_period_end.to_s, '%s')     unless stripe_object.current_period_end.nil?
          subscription.cancel_at_period_end      = stripe_object.cancel_at_period_end,                            
          subscription.stripe_plan               = JSON.parse(stripe_object.plan.to_json).deep_symbolize_keys     unless stripe_object.plan.nil?
          subscription.stripe_object             = stripe_object.object                                          
          subscription.start                     = Date.strptime(stripe_object.start.to_s, '%s')                  unless stripe_object.start.nil?
          subscription.stripe_customer           = stripe_object.customer                                        
          subscription.current_period_start      = Date.strptime(stripe_object.current_period_start.to_s, '%s')   unless stripe_object.current_period_start.nil?
          subscription.ended_at                  = Date.strptime(stripe_object.ended_at.to_s, '%s')               unless stripe_object.ended_at.nil?
          subscription.trial_start               = Date.strptime(stripe_object.trial_start.to_s, '%s')            unless stripe_object.trial_start.nil?
          subscription.trial_end                 = Date.strptime(stripe_object.trial_end.to_s, '%s')              unless stripe_object.trial_end.nil?
          subscription.canceled_at               = Date.strptime(stripe_object.canceled_at.to_s, '%s')            unless stripe_object.canceled_at.nil?
          subscription.quantity                  = stripe_object.quantity
          subscription.application_fee_percent   = stripe_object.application_fee_percent
          subscription.discount                  = JSON.parse(stripe_object.discount.to_json).deep_symbolize_keys unless stripe_object.discount.nil?
          subscription.tax_percent               = stripe_object.tax_percent
          subscription.metadata                  = JSON.parse(stripe_object.metadata.to_json).deep_symbolize_keys unless stripe_object.metadata.nil?
          
          subscription.finish!
          subscription.save!
        end
      end
    end
    
  end
  
  events.subscribe 'customer.subscription.updated' do |event|
    ap '########################################################'
    ap 'customer.subscription.updated'
    ap '########################################################'
    
    if stripe_data = event.data
      if stripe_object = stripe_data.object
        ap stripe_object
        
        if stripe_plan = stripe_object.plan
          plan = Plan.find_by(stripe_id: stripe_plan.id)
        
          if subscription = Subscription.find_by(stripe_id: stripe_object.id)
            subscription.update! 
            subscription.plan_id                   = plan.id                            
            #subscription.current_period_end        =  Date.strptime(stripe_object.current_period_end.to_s, '%s') unless stripe_object.current_period_end.nil?
            subscription.cancel_at_period_end      = stripe_object.cancel_at_period_end                         unless stripe_object.cancel_at_period_end.nil?
            subscription.stripe_plan               = JSON.parse(stripe_object.plan.to_json).deep_symbolize_keys unless stripe_object.plan.nil?
            subscription.stripe_object             = stripe_object.object
            #subscription.start                     = stripe_object.start.nil? ?                nil : Date.strptime(stripe_object.start.to_s, '%s'),
            #subscription.current_period_start      = stripe_object.current_period_start.nil? ? nil : Date.strptime(stripe_object.current_period_start.to_s, '%s'),
            #subscription.ended_at                  = stripe_object.ended_at.nil? ?             nil : Date.strptime(stripe_object.ended_at.to_s, '%s'),
            #subscription.trial_start               = stripe_object.trial_start.nil? ?          nil : Date.strptime(stripe_object.trial_start.to_s, '%s'),
            #subscription.trial_end                 = stripe_object.trial_end.nil? ?            nil : Date.strptime(stripe_object.trial_end.to_s, '%s'),
            #subscription.canceled_at               = stripe_object.canceled_at.nil? ?          nil : Date.strptime(stripe_object.canceled_at.to_s, '%s'),
            subscription.quantity                  = stripe_object.quantity
            subscription.application_fee_percent   = stripe_object.application_fee_percent
            subscription.discount                  = JSON.parse(stripe_object.discount.to_json).deep_symbolize_keys unless stripe_object.discount.nil?
            subscription.tax_percent               = stripe_object.tax_percent
            subscription.metadata                  = JSON.parse(stripe_object.metadata.to_json).deep_symbolize_keys unless stripe_object.metadata.nil?
          
            subscription.finish!
            subscription.save! 
            #subscription.save! ? subscription.finish! : subscription.fail!
          
            #StripeMailer.subscription_updated(subscription.id).deliver_now
          end
        end

      end
      
    end
  end
    
  events.subscribe 'customer.subscription.deleted' do |event|
    ap '########################################################'
    ap 'customer.subscription.deleted'
    ap '########################################################'
    if data = event.data
      if object = data.object
        if  subscription = Subscription.where(stripe_id: object.id).first
          subscription.destroy
        end
      end
    end
  end

  
  
  
  
  
  
  
  
  
  
  
  
  

  ########################################################
  # Customer CUD
  ########################################################
  
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

  
  
  
  
  
  
  
  ########################################################
  # Coupons CUD
  ########################################################
  
  events.subscribe 'coupon.created' do |event|
    ap '########################################################'
    ap 'coupon.created'
    ap '########################################################'
    if data = event.data
      if object = data.object
        stripe_id = object.id
        #ap stripe_id
        Coupon.where(stripe_id: stripe_id)
               .first_or_create(
                      stripe_id:          stripe_id,
                      percent_off:        object.percent_off,
                      amount_off:         object.amount_off,
                      currency:           object.currency,
                      duration:           object.duration,
                      redeem_by:          object.redeem_by.nil? ? nil : Date.strptime(object.redeem_by.to_s, '%s'), 
                      max_redemptions:    object.max_redemptions,
                      times_redeemed:     object.times_redeemed,
                      duration_in_months: object.duration_in_months,
                      metadata:           object.metadata
        )
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
  
  
  
  
  
  
  
  
  
  
  ########################################################
  # Plan CUD
  ########################################################
  # Create missing
  
  # Update missing
  events.subscribe 'plan.deleted' do |event|
    ap '########################################################'
    ap 'plan.deleted'
    ap '########################################################'
    stripe_id = event.data.object.id
    if  plan = Plan.where(stripe_id: stripe_id).first
      plan.destroy
    end
  end
  
  
  
  
  
  
  
  
  
  ########################################################
  # Invoice item CU
  ########################################################
  
  
  events.subscribe 'invoiceitem.created' do |event|
    ap '########################################################'
    ap 'invoiceitem.created'
    ap '########################################################'
    if data = event.data
      ap data
      #if object = data.object
      #  #stripe_id = object.id
      #  
      #  ap Invoice.where(   stripe_id: object.id)
      #  .first_or_create(   stripe_id:              object.id,           
      #                      stripe_object:          object.object,       
      #                      livemode:               object.livemode,            
      #                      amount_due:             object.amount_due.nil? ? nil : object.amount_due,          
      #                      attempted:              object.attempted.nil? ? nil : object.attempted,                  
      #                      closed:                 object.closed.nil? ? nil : object.closed,               
      #                      currency:               object.currency,            
      #                      stripe_customer_id:     object.customer_id,  
      #                      date:                   object.date.nil? ? nil : Date.strptime(object.date.to_s, '%s'),   
      #                      discountable:           object.discountable      
      #                      forgiven:               object.forgiven.nil? ? nil : object.forgiven,             
      #                      lines:                  object.lines.nil? ? nil : object.lines,                
      #                      paid:                   object.paid.nil? ? nil : object.paid,                 
      #                      period_start:           object.period_start.nil? ? nil : Date.strptime(object.period_start.to_s, '%s'),         
      #                      period_end:             object.period_end.nil? ? nil : Date.strptime(object.period_end.to_s, '%s'),           
      #                      starting_balance:       object.starting_balance,    
      #                      subtotal:               object.subtotal,            
      #                      total:                  object.total,               
      #                      application_fee:        object.application_fee,     
      #                      charge:                 object.charge,              
      #                      description:            object.description,         
      #                      discount:               object.discount,            
      #                      ending_balance:         object.ending_balance,      
      #                      receipt_number:         object.receipt_number,      
      #                      statement_descriptor:   object.statement_descriptor,
      #                      subscription_id:        object.subscription_id,     
      #                      metadata:               object.metadata,            
      #                      tax:                    object.tax,                 
      #                      tax_percent:            object.tax_percent,         
      #                      user_id:                object.user_id,             
      #                      account_id:             object.account_id,          
      #                      created_at:             object.created_at,          
      #                      updated_at:             object.updated_at  
      #                  )
      #  
      #  
      #  
      #  
      #  
      #end
    end
  end
  
  events.subscribe 'invoiceitem.updated' do |event|
    ap '########################################################'
    ap 'invoiceitem.updated'
    ap '########################################################'
    if data = event.data
      if object = data.object
        stripe_id = object.id
        ap Invoice.where(   stripe_id: stripe_id)
        .first_or_create(   stripe_id:              object.stripe_id,           
                            stripe_object:          object.stripe_object,       
                            livemode:               object.livemode,            
                            amount_due:             object.amount_due,          
                            attempted:              object.attempted,           
                            closed:                 object.closed,              
                            currency:               object.currency,            
                            stripe_customer_id:     object.stripe_customer_id,  
                            date:                   object.date.nil? ? nil : Date.strptime(object.date.to_s, '%s'),                
                            forgiven:               object.forgiven,            
                            lines:                  object.lines,               
                            paid:                   object.paid,                
                            period_start:           object.period_start.nil? ? nil : Date.strptime(object.period_start.to_s, '%s'),         
                            period_end:             object.period_end.nil? ? nil : Date.strptime(object.period_end.to_s, '%s'),           
                            starting_balance:       object.starting_balance,    
                            subtotal:               object.subtotal,            
                            total:                  object.total,               
                            application_fee:        object.application_fee,     
                            charge:                 object.charge,              
                            description:            object.description,         
                            discount:               object.discount,            
                            ending_balance:         object.ending_balance,      
                            receipt_number:         object.receipt_number,      
                            statement_descriptor:   object.statement_descriptor,
                            subscription_id:        object.subscription_id,     
                            metadata:               object.metadata,            
                            tax:                    object.tax,                 
                            tax_percent:            object.tax_percent,         
                            user_id:                object.user_id,             
                            account_id:             object.account_id,          
                            created_at:             object.created_at,          
                            updated_at:             object.updated_at  
                        )
        
        
        
        
        
      end
    end
  end
  


  
  ########################################################
  # Invoice CU
  ########################################################
  
  
  events.subscribe 'invoice.created' do |event|
    ap '########################################################'
    ap 'invoice.created'
    ap '########################################################'
    
  end
  
 
  
  
  
  
 
  
  events.subscribe 'invoice.payment_succeeded' do |event|
    ap '***************  invoice.payment_succeeded  ******************'
    #StripeSubscriptionMailer.receipt(stripe_event: event.data.object).deliver_now
    #ap event.data.object
    #if subscription = Subscription.where(stripe_id: event.data.object.id).first
    #StripeSubscriptionMailer.receipt(stripe_event: event.data.object).deliver_now
    #StripeSubscriptionMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_now
    #end
    #event = { stripe_event: event.data.object}
    #StripeMailer.receipt(stripe_event: event.data.object).deliver_now
    #StripeMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_now
  end
  
  
  

  
end