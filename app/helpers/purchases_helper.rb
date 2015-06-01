module PurchasesHelper
  
  def purchase_link_for order_line
    case order_line["productable_type"]
      
    when 'Sales::CouponBatch'
      batch_id = order_line["productable_id"].to_i
      #Sales::CouponBatch.find(batch_id)
      link_to 'Show', user_user_coupon_batch_path(@user, batch_id), class: 'btn btn-default btn-xs'
    end
  end
  
  
end
