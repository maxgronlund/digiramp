class AddStripeCouponObjectToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_coupon_object, :text
  end
end
