class UpdateRalationNamesOnStripeTransfers < ActiveRecord::Migration
  def change
    rename_column :shop_stripe_transfers, :shop_order_item_id, :order_item_id
    rename_column :shop_stripe_transfers, :shop_order_id, :order_id
    
    add_column :shop_stripe_transfers, :destination, :string
    add_column :shop_stripe_transfers, :source_transaction, :string
    add_column :shop_stripe_transfers, :currency, :string, default: 'usd'
  end
end
