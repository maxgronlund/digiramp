

StripeEvent.event_retriever = lambda do |params|
  
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])

end

StripeEvent.configure do |events|
  
  StripeCustomerSubscriptionService.new.subscribe( events )
  StripeCustomerService.new.subscribe events
  StripeCustomerSourceService.new.subscribe events
  StripeCouponService.new.subscribe events
  StripePlanService.new.subscribe events
  StripeInvoiceService.new.subscribe events
  
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
  


  
  
  
  
  
  
  

  
end