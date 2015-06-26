class AddCheckedOutToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :checked_out, :boolean, default: false
  end
end
