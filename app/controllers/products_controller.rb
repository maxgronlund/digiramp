#  ----------------------------------------
#  this is a product from a users public shop
# -----------------------------------------
class ProductsController < ApplicationController
  def show
    
    #!!! deal with no user
    #@user            = User.cached_find(params[:user_id])
    @user            = User.cached_find(params[:user_id])
    @shop_product    = Shop::Product.cached_find(params[:id])
    @shop_product.views += 1
    @shop_product.save
    @shop_order_item = Shop::OrderItem.new
    @shop_order      = current_order
    permit_special_offer
    
  end
  
  def buy
    
  end
  
  private
  def permit_special_offer
    return if super?
    return if @shop_product.exclusive_offered_to_email.blank?
    return forbidden unless current_user
    return forbidden unless current_user.email == @shop_product.exclusive_offered_to_email
  end
  

end

