class AddSoldToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :sold, :boolean
  end
end
