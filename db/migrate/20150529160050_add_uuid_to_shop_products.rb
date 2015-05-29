class AddUuidToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :uuid, :string
    
    Shop::Product.find_each do |product|
      product.uuid = UUIDTools::UUID.timestamp_create().to_s
      product.save!(validate: false)
    end
  end
end
