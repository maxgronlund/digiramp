class AddTotalPriceToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :total_price, :integer, default: 0
    
    #add_column :sales_coupon_batches, :plan_id, :integer
    #add_index :sales_coupon_batches, :plan_id
    #add_foreign_key :sales_coupon_batches, :plans
    
  end
end
