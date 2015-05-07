class CreateSubscription
  def self.call(plan, user, token)
    ##user, raw_token = CreateUser.call(email_address)
    #subscription    = Subscription.new( plan: plan, user: user )
    #
    #begin
    #  stripe_sub = nil
    #  if user.stripe_customer_id.blank?
    #    customer    = Stripe::Customer.create( source: token, email: user.email, plan: plan.stripe_id )
    #    user.stripe_customer_id = customer.id
    #    user.save!
    #    stripe_sub  = customer.subscriptions.first
    #  else
    #    customer    = Stripe::Customer.retrieve(user.stripe_customer_id)
    #    stripe_sub  = customer.subscriptions.create( plan: plan.stripe_id )
    #  end
    #  subscription.stripe_id = stripe_sub.id
    #  subscription.save!
    #
    #rescue Stripe::StripeError => e
    #  ap e.message
    #  Rails.flash[:danger] = e.message
    #  subscription.errors[:base] << e.message
    #end
    #subscription
  end
end