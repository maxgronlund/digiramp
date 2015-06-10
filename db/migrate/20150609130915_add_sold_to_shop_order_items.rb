class AddSoldToShopOrderItems < ActiveRecord::Migration
  def change
    add_column :shop_order_items, :sold, :boolean, default: false
  end
end
