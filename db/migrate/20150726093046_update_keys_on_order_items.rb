class UpdateKeysOnOrderItems < ActiveRecord::Migration
  def change
    remove_foreign_key "shop_stripe_transfers", "shop_order_items"
    add_foreign_key "shop_stripe_transfers", "shop_order_items", on_delete: :cascade
  end
end
