class CreateShopOrders < ActiveRecord::Migration
  def change
    drop_table :sales
    drop_table :products
    create_table :shop_orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :stripe_customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
