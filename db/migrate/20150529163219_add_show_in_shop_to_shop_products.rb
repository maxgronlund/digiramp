class AddShowInShopToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :show_in_shop, :boolean, default: false
    
    #Shop::Product.find_each do |product|
    #  product.update_show_in_shop
    #end
  end
end
