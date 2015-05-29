class AddOrderLinesToShopOrder < ActiveRecord::Migration
  def change
    add_column :shop_orders, :order_lines, :text
  end
end
