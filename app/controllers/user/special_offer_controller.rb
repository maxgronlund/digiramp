class User::SpecialOfferController < ApplicationController
  before_action :access_user
  def index
    @products = Shop::Product.where(exclusive_offer: @user.email)
  end
end
