class User::OrderItemsController < ApplicationController
  before_action :access_user
  
  def show
    @order_item       = Shop::OrderItem.cached_find(params[:id])
    @shop_product     = @order_item.product
    @stripe_transfers = @order_item.stripe_transfers
  end
  
end
