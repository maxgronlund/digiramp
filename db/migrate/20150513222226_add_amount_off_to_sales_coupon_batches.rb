class AddAmountOffToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :stripe_id, :string
    add_column :sales_coupon_batches, :amount_off, :integer
    add_column :sales_coupon_batches, :percent_off, :integer
    add_column :sales_coupon_batches, :duration,    :string
    add_column :sales_coupon_batches, :duration_in_months, :integer
    add_column :sales_coupon_batches, :currency, :string
    add_column :sales_coupon_batches, :number_of_coupons, :integer
    add_column :sales_coupon_batches, :times_redeemed, :integer
    add_column :sales_coupon_batches, :metadata, :text
    add_column :sales_coupon_batches, :plan_id, :integer
    add_column :sales_coupon_batches, :account_id, :integer
    add_column :sales_coupon_batches, :redeem_by, :date

  end
end
