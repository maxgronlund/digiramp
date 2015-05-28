class StripeChargeJob < ActiveJob::Base
  queue_as :default

  def perform(uuid)
    ap '-- perform --'
    ActiveRecord::Base.connection_pool.with_connection do
      order = Shop::Order.find_by(uuid: uuid)
      ap ' looking for the order'
      ap order
      return unless order
      order.process!
    end
  end

end

