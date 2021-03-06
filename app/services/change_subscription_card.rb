class ChangeSubscriptionCard
  def self.call(subscription, token)
    
    if user                 = subscription.user
      begin
        if customer           = Stripe::Customer.retrieve(user.stripe_customer_id)
          stripe_sub          = customer.subscriptions.retrieve(subscription.stripe_id)
          stripe_sub.source   = token
          stripe_sub.save
        else
          subscription.error << 'unable to find customer'
          subscription.save
          subscription.fail!
        end
      rescue Stripe::StripeError => e
        subscription.error << e.message
        subscription.save
        subscription.fail!
      end
    end
  end
end

#customer = Stripe::Customer.retrieve("cus_688tyu8yi65mHj")

