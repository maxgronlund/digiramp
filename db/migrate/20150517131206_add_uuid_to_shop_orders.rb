class AddUuidToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :uuid, :string
  end
end
