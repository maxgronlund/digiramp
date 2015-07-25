class AddOrderIdToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :invoice_nr, :integer, default: 0
  end
end
