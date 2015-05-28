class AddEmailToShopOrder < ActiveRecord::Migration
  def change
    add_column :shop_orders, :email, :string
  end
end
