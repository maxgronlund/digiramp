class AddChargeIdToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :charge_id, :string
    add_column :shop_orders, :invoice_object, :text
    remove_column :shop_orders, :stripe_customer_id, :string
  end
end
