# public shop
class Shop::ShopController < ApplicationController
  
  #http://localhost:3000/shop
  def index
    @user         = current_user
    @shop_order   = current_order
    
    
    @products     = Shop::Product.where(show_in_shop: true)
  end
  
  #def show
  #  ap 'show'
  #end
end
