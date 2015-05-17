class AddStateToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :state, :string
  end
end
