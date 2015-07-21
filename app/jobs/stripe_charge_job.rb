class StripeChargeJob < ActiveJob::Base
  queue_as :default

  def perform(shop_order_id)
    
    ActiveRecord::Base.connection_pool.with_connection do
      order = Shop::Order.cached_find(shop_order_id)
      #order.reset
      begin
        order.process!
      rescue
        order.update_attributes(error: 'Sorry something went wrong, please contace support')
      end
    end
  end

end

