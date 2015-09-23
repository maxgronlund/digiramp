class AddProductTypeToProducts < ActiveRecord::Migration
  def change
    change_column :shop_products, :productable_type, :string, default: 'Shop::Product'

    Shop::Product.find_each do |product|
      unless product.productable_type == 'Recording'
         product.update(productable_type: 'Shop::Product')
      end
    end
  end
end
