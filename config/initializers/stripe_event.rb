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
  
  
  events.subscribe 'plan.deleted' do |event|
    stripe_id = event.data.object.id
    if  plan = Plan.where(stripe_id: stripe_id).first
      plan.destroy
    end
    
  end
  
  
  events.subscribe 'customer.subscription.deleted' do |event|
    stripe_id = event.data.object.id
    if  subscription = Subscription.where(stripe_id: stripe_id).first
      subscription.destroy
    end
  end
  
  
  # users are changing to another plan
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
    ap 'customer.updated'
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
                    digiramp_subscription.reset!
                  end
                end
              end
            end
          end
        end
        ap object
        if sources =  object.sources
          if source_data = sources.data
            source_data.each do |payment_source|

              digiramp_payment_source = PaymentSource.where(stripe_id: payment_source.id).first_or_create(stripe_id: payment_source.id)
              digiramp_payment_source.stripe_data     = JSON.parse(payment_source.to_json).deep_symbolize_keys
              digiramp_payment_source.user_id         = digiramp_user.id if digiramp_user
              digiramp_payment_source.subscription_id = digiramp_subscription.id if digiramp_subscription
              digiramp_payment_source.save!
              ap digiramp_payment_source
              #:stripe_data

            end
          end
          
        end
        # sub_688tZqzz1r3Y54
        #customer = Stripe::Customer.retrieve("cus_688tyu8yi65mHj")
        # customer.subscriptions.retrieve
        #if stripe_customer = object.id
        #  ap id
        #end
      end
    end


  end
  
  events.subscribe 'customer.source.deleted' do |event|
    ap 'customer.source.deleted'
    #stripe_id = event.data.object.id
    #ap stripe_id
    #if subscription = Subscription.where(stripe_id: stripe_id).first
    #  
    #  subscription.source_deleted!
    #  #if stripe_plan = event.data.object.plan
    #  #  if stripe_id = stripe_plan.name
    #  #    if plan = Plan.where(stripe_id: stripe_id).first
    #  #      subscription.plan_id = plan.id
    #  #      subscription.save
    #  #      # 'send plane changed notification'
    #  #      StripeMailer.subscription_updated(stripe_event: event.data.object).deliver_now
    #  #    end
    #  #  end
    #  #end
    #end
  end
  #
  events.subscribe 'customer.source.created' do |event|
    ap 'customer.source.created'
    #stripe_id = event.data.object.id
    #ap stripe_id
    #if subscription = Subscription.where(stripe_id: stripe_id).first
    #  
    #   subscription.source_created!
    #  #if stripe_plan = event.data.object.plan
    #  #  if stripe_id = stripe_plan.name
    #  #    if plan = Plan.where(stripe_id: stripe_id).first
    #  #      subscription.plan_id = plan.id
    #  #      subscription.save
    #  #      # 'send plane changed notification'
    #  #      StripeMailer.subscription_updated(stripe_event: event.data.object).deliver_now
    #  #    end
    #  #  end
    #  #end
    #end
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