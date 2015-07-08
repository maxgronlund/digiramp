class RecordingDownload < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  belongs_to :product,    foreign_key: :shop_product_id, class_name:    "Shop::Product"
  belongs_to :order_item, foreign_key: :shop_order_item_id, class_name: "Shop::OrderItem"
end
