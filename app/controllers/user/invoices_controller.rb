class User::InvoicesController < ApplicationController
  
  layout 'invoices'
  
  
  def index
  end

  def show
    if @shop_order = Shop::Order.find_by(uuid: params[:id])
      session[:order_uuid] = nil
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
