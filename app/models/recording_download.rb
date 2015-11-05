class RecordingDownload < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  belongs_to :product,    foreign_key: :shop_product_id, class_name:    "Shop::Product"
  belongs_to :order_item, foreign_key: :order_item_id, class_name:      "Shop::OrderItem"
  
  def download_url
    self.recording.download_url2 if self.recording
  end
  
  def additional_download_url
    ap 'additional_download_url'
    ap self.product
    self.product.additional_download_url if self.product
  end
end
