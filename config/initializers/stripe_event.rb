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
  
  events.subscribe 'customer.subscription.updated' do |event|
    stripe_id = event.data.object.id
    if subscription = Subscription.where(stripe_id: stripe_id).first
      if stripe_plan = event.data.object.plan
        if stripe_id = stripe_plan.name
          if plan = Plan.where(stripe_id: stripe_id).first
            subscription.plan_id = plan.id
            subscription.save
            # 'send plane changed notification'
            StripeMailer.subscription_updated(stripe_event: event.data.object).deliver_now
          end
        end
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