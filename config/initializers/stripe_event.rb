StripeEvent.event_retriever = lambda do |params|
  
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])

end

StripeEvent.configure do |events|
  
  events.subscribe 'charge.dispute.created' do |event|
    StripeMailer.admin_dispute_created(stripe_event: event.data.object).deliver_later
  end
  
  events.subscribe 'charge.succeeded' do |event|
    StripeMailer.receipt(stripe_event: event.data.object).deliver_later
    StripeMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_later
  end
  
  
  ########################################################
  # Subscription source CUD
  events.subscribe 'customer.subscription.updated' do |event|

    stripe_subscription_id = event.data.object.id
    
    if digiramp_subscription = Subscription.where(stripe_id: stripe_subscription_id).first                                                            
      if stripe_plan = event.data.object.plan
        if stripe_plan_id = stripe_plan.id
          if digiramp_plan = Plan.where(stripe_id: stripe_plan_id).first
            digiramp_subscription.plan_id = digiramp_plan.id
            digiramp_subscription.save
            digiramp_subscription.finish!
            # 'send plane changed notification'
            StripeMailer.subscription_updated(stripe_event: event.data.object).deliver_now
          end
        end
      end
    end
  end
  
  # The info on the cc is updated for a given subscription
  events.subscribe 'customer.updated' do |event|
    #ap 'customer.updated'
    digiramp_user         = nil
    digiramp_subscription = nil
    if data = event.data
      if object = data.object
        if stripe_subscriptions = object.subscriptions
          if subscriptions_data = stripe_subscriptions.data
            subscriptions_data.each do |stripe_data|
              if stripe_id = stripe_data.id
                if digiramp_subscription = Subscription.where(stripe_id: stripe_id).first
                  digiramp_user = digiramp_subscription.user
                  begin
                    digiramp_subscription.finish!
                  rescue  => error
                    digiramp_subscription.error = error.inspect
                    digiramp_subscription.save
                    digiramp_subscription.fail!
                  end
                end
              end
            end
          end
        end
        #ap object
        if sources =  object.sources
          if sources_data = sources.data
            source_datas.each do |payment_source|
              digiramp_user_id          = digiramp_user.nil? ? nil: digiramp_user.id  
              digiramp_subscription_id  = digiramp_subscription.nil? ? nil: digiramp_subscription.id  
              PaymentSource.where(stripe_id: payment_source.id)
                              .first_or_create(  stripe_id:              payment_source.id,
                                                 stripe_data:            JSON.parse(payment_source.to_json).deep_symbolize_keys, 
                                                 user_id:                digiramp_user_id,
                                                 subscription_id:        digiramp_subscription_id
                                              )
            end
          end
        end
      end
    end
  end
  
  events.subscribe 'customer.subscription.deleted' do |event|
    ap 'customer.subscription.deleted'
    stripe_id = event.data.object.id
    if  subscription = Subscription.where(stripe_id: stripe_id).first
      subscription.destroy
    end
  end

  
  ########################################################
  # Customer payment source CUD
  events.subscribe 'customer.source.created' do |event|
    ap 'customer.source.created'
    if data = event.data
      if stripe_payment_source = data.object
        stripe_id = stripe_payment_source.id
        if digiramp_payment_source = PaymentSource.where(  stripe_id:    stripe_id)
                                        .first_or_create(  stripe_id:    stripe_id,
                                                           stripe_data:  JSON.parse(stripe_payment_source.to_json).deep_symbolize_keys,
                                                        )
          if customer_stripe_id = digiramp_payment_source.stripe_data[:customer]
            
          end
        end
        
      end
    end
  end
  
  events.subscribe 'customer.source.updated' do |event|
    ap 'customer.source.updated'
    if data = event.data
      if object = data.object
        if stripe_id = object.id
          if digiramp_payment_source  = PaymentSource.where(stripe_id: stripe_id).first
            digiramp_payment_source.stripe_data = JSON.parse(object.to_json).deep_symbolize_keys
            digiramp_payment_source.save
          end
        end
      end
    end
  end
  
  events.subscribe 'customer.source.deleted' do |event|
    ap 'customer.source.deleted'
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
  events.subscribe 'coupon.created' do |event|
    ap 'coupon.created'
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
    ap 'coupon.deleted'
    if data = event.data
      if object = data.object
        stripe_id = object.id
        if coupon = Coupon.where(stripe_id: stripe_id).first
          coupon.destroy
        end
      end
    end
  end
  
  
  
  ######################################################
  # Plan CUD
  
  # Create missing
  
  # Update missing
  events.subscribe 'plan.deleted' do |event|
    stripe_id = event.data.object.id
    if  plan = Plan.where(stripe_id: stripe_id).first
      plan.destroy
    end
  end
  
  
  ######################################################
  # Invoice item CU
  
  
  
  
  
  
  
  
  
  # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  
  events.subscribe 'invoiceitem.created' do |event|
    ap 'invoiceitem.created'
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
    ap 'invoiceitem.updated'
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
  
  
  
  
 
  
  #events.subscribe 'invoice.payment_succeeded' do |event|
  #  ap '***************  invoice.payment_succeeded  ******************'
  #  StripeSubscriptionMailer.receipt(stripe_event: event.data.object).deliver_now
  #  #ap event.data.object
  #  #if subscription = Subscription.where(stripe_id: event.data.object.id).first
  #  #StripeSubscriptionMailer.receipt(stripe_event: event.data.object).deliver_now
  #  #StripeSubscriptionMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_now
  #  #end
  #  #event = { stripe_event: event.data.object}
  #  #StripeMailer.receipt(stripe_event: event.data.object).deliver_now
  #  #StripeMailer.admin_charge_succeeded(stripe_event: event.data.object).deliver_now
  #end
  
  
  

  
end