class StripeChargerSubscriptionJob < ActiveJob::Base
  queue_as :default

  def perform(guid)
    ActiveRecord::Base.connection_pool.with_connection do
      subscription = Subscription.find_by(guid: guid)
      return unless subscription
      subscription.process!
    end
  end
end
