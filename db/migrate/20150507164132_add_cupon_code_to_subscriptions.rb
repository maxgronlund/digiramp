class AddCuponCodeToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :coupon_code, :string
  end
end
