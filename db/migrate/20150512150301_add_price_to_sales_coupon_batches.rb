class AddPriceToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :discount, :integer
  end
end
