class UpdateShopOrderItems < ActiveRecord::Migration
  def change
    
    remove_column :shop_order_items, :shop_order_id, :integer
    remove_column :shop_order_items, :shop_product_id, :integer
    
    add_column :shop_order_items, :order_id, :integer
    add_column :shop_order_items, :product_id, :integer
    
    add_index :shop_order_items, :order_id
    add_index :shop_order_items, :product_id
    
  end
end
