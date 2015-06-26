class StripeChargeJob < ActiveJob::Base
  queue_as :default

  def perform(uuid)
    ap '===================== hit job =============================='
    ActiveRecord::Base.connection_pool.with_connection do
      order = Shop::Order.find_by(uuid: uuid)
      #order.reset
      begin
        order.process!
      rescue
        self.update_attributes(error: 'Sorry something went wrong, please contace support')
      end
    end
  end

end

