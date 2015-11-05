class RenameShopOrderItemId < ActiveRecord::Migration
  def change
    rename_column :shop_stripe_transfers, :shop_order_item_id, :order_item_id
  end
end
