class StripeChargeJob < ActiveJob::Base
  queue_as :default

  def perform(uuid)
    
    ActiveRecord::Base.connection_pool.with_connection do
      order = Shop::Order.find_by(uuid: uuid)
      #order.reset
      begin
        order.process!
      rescue
        order.update_attributes(error: 'Sorry something went wrong, please contace support')
      end
    end
  end

end

