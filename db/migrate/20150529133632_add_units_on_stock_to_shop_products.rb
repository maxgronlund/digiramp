class AddUnitsOnStockToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :units_on_stock, :integer
    add_column :shop_products, :exclusive_offer, :string
  end
end
