class AddStripeTokenToShopItems < ActiveRecord::Migration
  def change
    add_column :shop_orders, :stripe_token, :string
  end
end
