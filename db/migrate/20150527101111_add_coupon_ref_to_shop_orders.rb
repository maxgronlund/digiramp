class AddCouponRefToShopOrders < ActiveRecord::Migration
  def change
    add_reference :shop_orders, :coupon, index: true, foreign_key: true
  end
end
