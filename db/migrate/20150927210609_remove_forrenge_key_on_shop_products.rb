class RemoveForrengeKeyOnShopProducts < ActiveRecord::Migration
  def change
    remove_foreign_key "shop_products", "documents"
  end
end
