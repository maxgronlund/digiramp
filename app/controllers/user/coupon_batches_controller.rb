class User::CouponBatchesController < ApplicationController
  before_action :access_user
  def show
    @coupon_batch = Sales::CouponBatch.find(params[:id])
  end
end
