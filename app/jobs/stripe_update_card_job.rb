class StripeUpdateCardJob < ActiveJob::Base
  queue_as :default

  def perform(guid, token)
    #error = false
    ActiveRecord::Base.connection_pool.with_connection do
      if subscription = Subscription.find_by(guid: guid)

        subscription.reset!
        subscription.update!
        subscription.error = ''

        if user                   = subscription.user
          begin
            if customer           = Stripe::Customer.retrieve(user.stripe_customer_id)
              stripe_sub          = customer.subscriptions.retrieve(subscription.stripe_id)
              stripe_sub.source   = token
              stripe_sub.save
              subscription.finish!
            else
              subscription.error << 'unable to find customer'
              #error = true
              subscription.fail!
            end
          rescue Stripe::StripeError => e
            subscription.error << e.message
            subscription.fail!
            #error = true
          end
        else
          #error = true  
          subscription.error << 'User not found'
        end
        subscription.save
      end
      #subscription.fail! if error
    end
  end
end
