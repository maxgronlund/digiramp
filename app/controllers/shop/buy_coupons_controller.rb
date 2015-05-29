class Shop::BuyCouponsController < ApplicationController
  

  
  def show
    @shop_order   = current_order
    @months       = CreditCard.months
    @years        = CreditCard.years
    @coupon_batch = Sales::CouponBatch.find_by(uuid: params[:id])
  end
  
  
end
