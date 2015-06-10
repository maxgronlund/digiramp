class AddShippingAddressToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :shipping_address, :string
    add_column :shop_orders, :billing_address, :string
  end
end
