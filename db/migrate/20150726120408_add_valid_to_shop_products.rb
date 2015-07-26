class AddValidToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :valid_for_sale,  :boolean, default: false
    add_column :recordings,     :valid_for_sale, :boolean, default: false

  end
end
