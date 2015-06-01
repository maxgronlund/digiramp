class AddProductableRefToShopProducts < ActiveRecord::Migration
  def change
    add_reference :shop_products, :productable, index: true, polymorphic: true
  end
end
