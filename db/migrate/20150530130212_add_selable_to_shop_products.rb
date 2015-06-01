class AddSelableToShopProducts < ActiveRecord::Migration
  def change
    add_column :sales_coupon_batches, :product_uuid, :string
  end
end
