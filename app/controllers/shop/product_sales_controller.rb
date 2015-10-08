class Shop::ProductSalesController < ApplicationController
  def index
    @user         = current_user
    @shop_order   = current_order
    @products     = Shop::Product.on_sale.where(show_in_shop: true, productable_type: 'Shop::Product')
  end
end