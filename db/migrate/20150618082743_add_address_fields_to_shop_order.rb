class AddAddressFieldsToShopOrder < ActiveRecord::Migration
  def change
    add_column :shop_orders, :card_address_name, :text
    add_column :shop_orders, :card_address_line_1, :text
    add_column :shop_orders, :card_address_line_2, :text
    add_column :shop_orders, :card_address_city, :string
    add_column :shop_orders, :card_address_state, :string
    add_column :shop_orders, :card_address_zip, :string
    add_column :shop_orders, :card_address_country, :string
  end
end
