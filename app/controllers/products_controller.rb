#  ----------------------------------------
#  this is a product from a users public shop
# -----------------------------------------
class ProductsController < ApplicationController
  def show
    
    #!!! deal with no user
    #@user            = User.cached_find(params[:user_id])
    @user            = User.cached_find(params[:user_id])
    @shop_product    = Shop::Product.cached_find(params[:id])
    @shop_order_item = Shop::OrderItem.new
    @shop_order      = current_order
    
  end
  
  def buy
    
  end
  
  #def show
  #  ap "ProductsController#show"
  #  
  #end
end
