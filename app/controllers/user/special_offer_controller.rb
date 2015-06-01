class User::SpecialOfferController < ApplicationController
  before_action :access_user
  def index
    @products = Shop::Product.where(exclusive_offered_to_email: @user.email, units_on_stock: 1)
  end
end
