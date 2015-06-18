class RemoveAddressOnOrders < ActiveRecord::Migration
  def change
    remove_column :shop_orders, :shipping_address
  end
end
