class User::PurchasesController < ApplicationController
  before_action :access_user
  def index
    @shop_orders = Shop::Order.where(user_id: @user.id).order('updated_at desc')
  end

  def show
    forbidden unless @shop_order = Shop::Order.find_by(uuid: params[:id]) 
  end
end
