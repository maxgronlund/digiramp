
class ShopOrderService
  
  def self.handle_downloabels shop_order
    ap 'sh'
    shop_order.order_items.each do |order_item|
      ap 'oi'
      if product = order_item.shop_product
        ap 'pr'
        case product.category
          
        when 'recording'
          recording = Recording.cached_find(product.recording_id)
          ap RecordingDownload.where(user_id: shop_order.user_id, 
                                  recording_id: product.recording_id)
                           .first_or_create(user_id: shop_order.user_id, 
                                            recording_id: product.recording_id,
                                            uuid: UUIDTools::UUID.timestamp_create().to_s,
                                            shop_order_item_id: order_item.id,
                                            shop_product_id: product.id)
        end
      end
    end
    
    
  end
end



# ShopOrderService.handle_downloabels shop_order