class User::InvoicesController < ApplicationController
  
  layout 'invoices'
  
  
  def index
  end

  def show
    if @shop_order = Shop::Order.cached_find(params[:id])
      session[:order_id] = nil
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => @shop_order.id.to_s
        end
      end
    else
      not_found
    end
  end
end
