class AddOriginalPriceToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :original_price, :integer, default: 0
  end
end
