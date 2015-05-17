class Shop::BuyCouponsController < ApplicationController
  

  
  def show
    @months = CreditCard.months
    @years  = CreditCard.years
    @coupon_batch = Sales::CouponBatch.find_by(uuid: params[:id])
  end
end
