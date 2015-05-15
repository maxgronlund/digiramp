class AddDownloadUuidToSalesCouponBatches < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :download_uuid, :string
  end
end
