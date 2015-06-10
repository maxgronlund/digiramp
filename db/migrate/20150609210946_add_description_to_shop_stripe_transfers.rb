class AddDescriptionToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :description, :string
  end
end
