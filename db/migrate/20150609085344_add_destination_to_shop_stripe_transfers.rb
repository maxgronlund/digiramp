class AddDestinationToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :destination, :string
  end
end
