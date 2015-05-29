
class ShopController < ApplicationController
  def index
    
    @user       = User.cached_find(params[:user_id])
    @products   = @user.products.where(show_in_shop: true)
    @shop_order = current_order
    #@shop_products = Shop::Product.where(for_sale: true)
  end

  def show
  end
end
