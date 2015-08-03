# public shop
class Shop::ShopController < ApplicationController
  
  #http://localhost:3000/shop
  def index
    @user         = current_user
    @shop_order   = current_order
    
    
    @products     = Shop::Product.on_sale.where(show_in_shop: true)
  end
  

end
