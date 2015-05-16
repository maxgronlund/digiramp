class CreateShopOrders < ActiveRecord::Migration
  def change
    create_table( :shop_orders, :uuid, default: "uuid_generate_v4()") do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :stripe_customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
