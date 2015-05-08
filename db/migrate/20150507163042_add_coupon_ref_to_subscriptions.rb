class AddCouponRefToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :coupon, index: true, foreign_key: true
  end
end
