class AddRequireShippingToOrderItems < ActiveRecord::Migration
  def change
    add_column :shop_order_items, :require_shipping, :boolean, default: false
  end
end
