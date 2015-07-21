# general controller for adding a product to a basket/order

class Shop::ShopOrderItemsController < ApplicationController
  
  
  # add product to basket
  def create
    
    order_item_params = params[:shop_order_item]

    product           = Shop::Product.cached_find(order_item_params[:shop_product_id])
    quantity          = set_quantity( current_order, product, order_item_params[:quantity].to_i)
    
    if order_item = current_order.order_items.find_by(shop_product_id: product.id)
      # add quantity 
      order_item.quantity += quantity
      order_item.save
    else
      # create new with the right quantity
      order_item = current_order.order_items.create(quantity: quantity, shop_product_id: product.id)
    end
    
    ap order_item
    flash[:info] = "#{order_item.shop_product.title} is added to your basket" 

    

    #shop_order.order_items
    go_to = session[:return_url]
    session[:return_url] = nil
    redirect_to go_to
  end
  

  def update

    order_item          = Shop::OrderItem.cached_find(params[:id])
    OrderValidator.set_units_on_order_item(order_item, params[:shop_order_item][:quantity].to_i)

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
  
  private 
  
  def set_quantity order, product, quantity
    
    return 1 if product.category != 'physical-product'
    
    quantity    = 0 if quantity < 0
    units_left  = product.units_on_stock.to_i - quantity - order.units_of_product( product.id )
    quantity    += units_left if units_left < 0
    quantity
    
  end
end
