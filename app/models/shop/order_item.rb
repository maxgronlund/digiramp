class Shop::OrderItem < ActiveRecord::Base
  belongs_to :shop_order
  belongs_to :shop_product
end
