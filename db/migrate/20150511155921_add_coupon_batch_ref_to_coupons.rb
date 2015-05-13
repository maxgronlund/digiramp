class AddCouponBatchRefToCoupons < ActiveRecord::Migration
  def change
    add_reference :coupons, :sales_coupon_batch, index: true
  end
end
