class AddApplicationFeeToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :application_fee, :integer
  end
end
