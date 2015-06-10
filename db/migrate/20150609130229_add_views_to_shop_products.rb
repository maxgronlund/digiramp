class AddViewsToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :views, :integer, default: 0
  end
end
