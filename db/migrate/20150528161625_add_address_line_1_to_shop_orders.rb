class AddAddressLine1ToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :address_line_1, :string
    add_column :shop_orders, :address_line_2, :string
    add_column :shop_orders, :city, :string
    add_column :shop_orders, :zip, :string
    add_column :shop_orders, :country, :string
  end
end
