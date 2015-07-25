
class ShopOrderService

  
  def self.handle_downloabels shop_order
    begin
      shop_order.order_items.each do |order_item|

        if product = order_item.shop_product

          case product.productable_type
            
          when 'Recording'
            #recording = Recording.cached_find(product.recording_id)
            RecordingDownload.where(    user_id: shop_order.user_id, 
                                        recording_id: product.productable_id)
                             .first_or_create(user_id: shop_order.user_id, 
                                              recording_id: product.productable_id,
                                              uuid: UUIDTools::UUID.timestamp_create().to_s,
                                              shop_order_item_id: order_item.id,
                                              shop_product_id: product.id)
          #else
          #  ErrorNotifications.post "ShopOrderService#handle_downloabels: #{product.productable_type} type not found"
          end
        else
          ErrorNotifications.post "ShopOrderService#handle_downloabels: shop_product not found"
        end
      end
    rescue => e
      ErrorNotifications.post "ShopOrderService#handle_downloabels: #{e.inspect}"
    end
  end
end



# ShopOrderService.handle_downloabels shop_order