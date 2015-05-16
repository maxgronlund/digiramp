class Shop::ShopController < ApplicationController
  def index
    @shop_products = Shop::Product.where(for_sale: true)
  end
end
