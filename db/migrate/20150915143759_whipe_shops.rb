class WhipeShops < ActiveRecord::Migration
  def change
    Shop::OrderItem.destroy_all
    RecordingDownload.destroy_all
    Shop::Product.destroy_all
  end
end
