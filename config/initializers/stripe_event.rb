

StripeEvent.event_retriever = lambda do |params|
  
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  return nil if Rails.env.production? && !params[:livemode]
  
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
  StripeChargeService.new.subscribe events
  StripeTransferService.new.subscribe events
 
end




#Opbeat.capture_message("Not happy with the way things turned out")