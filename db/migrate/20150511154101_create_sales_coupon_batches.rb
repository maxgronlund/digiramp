class CreateSalesCouponBatches < ActiveRecord::Migration
  def change
    create_table :sales_coupon_batches do |t|
      t.string :title
      t.text :body
      t.string :email
      t.string :created_by

      t.timestamps null: false
    end
  end
end
