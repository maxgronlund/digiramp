class AddDestinationPaymentToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :destination_payment, :string
  end
end
