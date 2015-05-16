class ShopController < ApplicationController
  def index
    @user = User.cached_find(params[:user_id])
    @products = @user.products
  end

  def show
  end
end
