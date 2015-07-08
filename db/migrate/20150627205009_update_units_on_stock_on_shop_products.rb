class UpdateUnitsOnStockOnShopProducts < ActiveRecord::Migration
  def change
    change_column :shop_products, :units_on_stock, :integer, :default => 0
  end
end
