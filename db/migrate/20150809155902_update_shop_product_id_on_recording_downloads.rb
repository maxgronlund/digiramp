class UpdateShopProductIdOnRecordingDownloads < ActiveRecord::Migration
  def change
    
    remove_column :recording_downloads, :shop_product_id
    RecordingDownload.destroy_all
    
    add_column :recording_downloads, :shop_product_id, :uuid
    
    add_index :recording_downloads, :shop_product_id
    add_foreign_key "recording_downloads", "shop_products"
  end
end
