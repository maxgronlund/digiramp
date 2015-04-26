class ChangeSubscriptionCard
  def self.call(subscription, token)
    begin
      user                  = subscription.user
      customer              = Stripe::Customer.retrieve(user.stripe_customer_id)
      stripe_sub            = customer.subscriptions.retrieve(subscription.stripe_id)
      stripe_sub.source     = token
      stripe_sub.save
      
      
      
      
      #customer = Stripe::Customer.retrieve({CUSTOMER_ID})
      #user                  = subscription.user
      #customer              = Stripe::Customer.retrieve(user.stripe_customer_id)
      #stripe_subscription   = customer.subscriptions.retrieve(subscription.stripe_id)
      
      
      
      #if sources               = stripe_sub.sources
      #  if data = sources.data
      #    if card_id = data[0].id
      #      card  = customer.sources.retrieve(card_id)
      #      card.name             = subscription.cardholders_name
      #      card.save
      #    end
      #  end
      #end
      
      
      #card                  = customer.sources.retrieve({CARD_ID})
      #card.name             = subscription.cardholders_name
      #card.save
      
      
    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
  end
    subscription
  end
end