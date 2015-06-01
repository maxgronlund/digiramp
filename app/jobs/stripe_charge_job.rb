class StripeChargeJob < ActiveJob::Base
  queue_as :default

  def perform(uuid)
    
    ActiveRecord::Base.connection_pool.with_connection do
      order = Shop::Order.find_by(uuid: uuid)
      return unless order
      order.process!
    end
  end

end

