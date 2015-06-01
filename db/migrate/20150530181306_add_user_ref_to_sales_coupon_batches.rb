class AddUserRefToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_reference :sales_coupon_batches, :user, index: true, foreign_key: true
  end
end
