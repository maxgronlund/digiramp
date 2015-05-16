class AddCategoryToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :category, :string
  end
end
