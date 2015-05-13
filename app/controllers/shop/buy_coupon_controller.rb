class Shop::BuyCouponController < ApplicationController
  def show
    @coupon_batch = Sales::CouponBatch.where(uuid: params[:coupon])
  end
end
