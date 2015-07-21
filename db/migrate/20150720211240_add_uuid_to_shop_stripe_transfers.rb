class AddUuidToShopStripeTransfers < ActiveRecord::Migration
  def change
    add_column :shop_stripe_transfers, :stake_uuid, :uuid
    add_column :stakes, :uuid, :uuid

  end
end
