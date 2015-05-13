class AddSubjectToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :subject, :string
  end
end
