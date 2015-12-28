class AddProductUuidToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :shop_product_id, :uuid
    add_column :stakes, :description, :string
    
    Stake.update_all( description: '')
    
    Shop::Product.where(:productable_type => "Recording").each do |shop_product|
      shop_product.update_stakes
    end
  end
end
