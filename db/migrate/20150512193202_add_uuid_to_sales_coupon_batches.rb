class AddUuidToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :uuid, :string
    
    Sales::CouponBatch.find_each do |sb|
      sb.uuid = UUIDTools::UUID.timestamp_create().to_s
      sb.save(validates: false)
    end
  end
end
