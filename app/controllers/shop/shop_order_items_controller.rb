# general controller for adding a product to a basket/order

class Shop::ShopOrderItemsController < ApplicationController
  
  
  # add product to basket
  def create

    if shop_order_item = params[:shop_order_item]
      #if shop_order_id = shop_order_item[:shop_order_id]
      #  if shop_order = Shop::Order.find_by(uuid: shop_order_id)
          if order_item = current_order.order_items.find_by(product_id: shop_order_item[:shop_product_id].to_i)
            order_item.quantity += shop_order_item[:quantity].to_i
            order_item.save
          else
            current_order.order_items.create(quantity: shop_order_item[:quantity], product_id: shop_order_item[:shop_product_id])
          end
          #error = false
          #redirect_to_return_url user_product_path(shop_order_item[:user_id], shop_order_item[:shop_product_id])
      #  end
      #end
    end

    #shop_order.order_items
    go_to = session[:return_url]
    session[:return_url] = nil
    redirect_to go_to
  end
  

  def update

    order_item = Shop::OrderItem.cached_find(params[:id])
    order_item.quantity = params[:shop_order_item][:quantity].to_i
    order_item.save

    go_to = session[:return_url]
    session[:return_url] = nil
    redirect_to go_to

  end

  def destroy
    go_to = session[:return_url]
    session[:return_url] = nil
    order_item = Shop::OrderItem.cached_find(params[:id])
    order_item.destroy
    redirect_to go_to
    #redirect_to_return_url user_product_path(shop_order_item[:user_id], shop_order_item[:shop_product_id])
  end
end
