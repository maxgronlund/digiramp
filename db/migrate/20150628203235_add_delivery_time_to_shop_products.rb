class AddDeliveryTimeToShopProducts < ActiveRecord::Migration
  def change
    add_column :shop_products, :delivery_time, :string      , default: 'Two to four days'
    add_column :shop_products, :shipping_cost, :integer     , default: ''
    add_column :shop_products, :disclaimer, :text           , default: ''
    add_column :shop_products, :tems_of_usage, :text        , default: ''
    add_column :shop_products, :vat, :integer               , default: 0
    add_column :shop_products, :vat_included, :boolean      , default: true
    add_column :shop_products, :sub_category, :string           , default: ''
    add_column :shop_products, :zip_file, :string           
    add_reference :shop_products, :recording, index: true
    add_reference :shop_products, :playlist, index: true
    
  end
end
