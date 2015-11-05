class UpdateRecordingDownloadOrderItemId < ActiveRecord::Migration
  def change
    remove_column :recording_downloads, :shop_order_item_id, :integer
    add_column :recording_downloads, :order_item_id, :uuid
  end
end
