# public shop
class Shop::ShopController < ApplicationController
  
  #http://localhost:3000/shop
  def index
    ap 'index'
    @products = Shop::Product.where(for_sale: true)
  end
  
  #def show
  #  ap 'show'
  #end
end
