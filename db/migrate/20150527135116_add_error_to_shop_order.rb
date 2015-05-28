class AddErrorToShopOrder < ActiveRecord::Migration
  def change
    add_column :shop_orders, :error, :string
  end
end
