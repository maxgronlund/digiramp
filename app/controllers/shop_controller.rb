class ShopController < ApplicationController
  def index
    @user = User.cached_find(params[:user_id])
    @products = @user.products.where(for_sale: true)
    #@shop_products = Shop::Product.where(for_sale: true)
  end

  def show
  end
end
