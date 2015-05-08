class AddStripeObjectToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :stripe_object, :text
  end
end
