class AddCouponBatchsRefToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :coupon_batch_id, :integer
    add_index :coupons, :coupon_batch_id
    add_foreign_key :coupons, :sales_coupon_batches
    #add_reference :coupons, :coupon_batch, index: true, foreign_key: true
  end
end
