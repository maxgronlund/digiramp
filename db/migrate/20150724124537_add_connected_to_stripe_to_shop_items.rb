class AddConnectedToStripeToShopItems < ActiveRecord::Migration
  def change
    add_column :shop_products, :connected_to_stripe, :boolean, default: false
    Shop::Product.update_all(connected_to_stripe: true)
  end
end
