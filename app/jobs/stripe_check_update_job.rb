class StripeCheckUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(guid)

    ActiveRecord::Base.connection_pool.with_connection do
      subscription = Subscription.find_by(guid: guid)
      return unless subscription
      if subscription.state == 'processing'
        subscription.error = 'unable to process card'
        subscription.save!
        subscription.finish!
      elsif subscription.state == 'errored'
        
        
        
        
        
        # send error to user here
        
        
        
        
      end
      #subscription.update_card(token)
    end
  end
end
