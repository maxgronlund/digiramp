class StripeUpdateCardJob < ActiveJob::Base
  queue_as :default

  def perform(guid, token)
    ActiveRecord::Base.connection_pool.with_connection do
      if subscription = Subscription.find_by(guid: guid)
        return unless subscription
        if user                   = subscription.user
          begin
            if customer           = Stripe::Customer.retrieve(user.stripe_customer_id)
              stripe_sub          = customer.subscriptions.retrieve(subscription.stripe_id)
              stripe_sub.source   = token
              stripe_sub.save
            else
              subscription.error << 'unable to find customer'
              subscription.fail!
            end
          rescue Stripe::StripeError => e
            ap e.message
            subscription.error << e.message
            subscription.fail!
          end
        else
          subscription.fail!     
          subscription.error << 'User not found'
        end
        subscription.save
      end
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      #ChangeSubscriptionCard.call(subscription, token )
      #subscription.update_card(token)
    end
  end
end
