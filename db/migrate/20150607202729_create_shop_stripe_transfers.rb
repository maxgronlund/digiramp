class CreateShopStripeTransfers < ActiveRecord::Migration
  def change
    create_table :shop_stripe_transfers do |t|
      t.belongs_to :shop_order_item, index: true, foreign_key: true
      t.belongs_to :shop_order, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.decimal :split
      t.date :due_date
      t.integer :amount

      t.timestamps null: false
    end
  end
end
