class StripeUpdateCardJob < ActiveJob::Base
  queue_as :default

  def perform(guid, token)
    ActiveRecord::Base.connection_pool.with_connection do
      subscription = Subscription.find_by(guid: guid)
      return unless subscription
      ChangeSubscriptionCard.call(subscription, token )
      #subscription.update_card(token)
    end
  end
end
