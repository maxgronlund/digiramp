class CreateShopPhysicalProducts < ActiveRecord::Migration
  def change
    create_table :shop_physical_products do |t|
      t.string :dimensions
      t.string :waight
      t.integer :shipping_cost
      t.integer :units_on_stock

      t.timestamps null: false
    end
  end
end
