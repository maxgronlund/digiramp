class Shop::InvoicesController < ApplicationController
  
  #layout 'invoices'
  
  def show
    @user = current_user
    @shop_order   = current_order
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
