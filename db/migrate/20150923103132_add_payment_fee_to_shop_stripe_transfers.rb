class AddPaymentFeeToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :payment_fee, :integer
  end
end
