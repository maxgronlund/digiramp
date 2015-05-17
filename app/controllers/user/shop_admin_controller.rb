class User::ShopAdminController < ApplicationController
  before_action :access_user
  def index
    @shop_products = @user.products
  end
end
