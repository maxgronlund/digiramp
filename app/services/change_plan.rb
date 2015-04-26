class ChangePlan
  def self.call(subscription, to_plan)
    from_plan = subscription.plan
    begin
      user                = subscription.user
      customer            = Stripe::Customer.retrieve(user.stripe_customer_id)
      stripe_sub          = customer.subscriptions.retrieve(subscription.stripe_id)
      stripe_sub.plan     = to_plan.stripe_id
      stripe_sub.save
      subscription.plan   = to_plan
      subscription.save!
    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
    end
    subscription
  end
end