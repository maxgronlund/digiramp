class AddAccountIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :shop_order_items, :account_id, :integer
    
    Shop::OrderItem.find_each do |order_item|
      order_item.account_id = order_item.shop_product.account_id
      order_item.save!
    end
  end
end
