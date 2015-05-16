class CreateShopOrderItems < ActiveRecord::Migration
  def change
    create_table :shop_order_items do |t|
      t.belongs_to :shop_order, index: true, foreign_key: true
      t.belongs_to :shop_product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
