class Shop::OrdersController < ApplicationController
  

  # GET /shop/orders
  # GET /shop/orders.json
  #def index
  #  @shop_orders = Shop::Order.all
  #end

  # GET /shop/orders/1
  # GET /shop/orders/1.json
  def show
    @user         = current_user
    @shop_order   = current_order
    @total_price  = @shop_order.total_price
  end

  # GET /shop/orders/1/edit
  def edit
    @shop_order   = current_order
    if error_message = @shop_order.invalid?
      flash[:danger] = error_message
      redirect_to shop_order_path( @shop_order )
    else
      @user         = current_user
      @shop_order.reset!
      @total_price  = @shop_order.total_price
      @years        = CreditCard.years
      @months       = CreditCard.months
    end

  end

  # PATCH/PUT /shop/orders/1
  # PATCH/PUT /shop/orders/1.json
  def update
    
    params[:shop_order][:email]           = params[:email]
    params[:shop_order][:stripe_token]    = params[:stripeToken]
    params[:stripeToken]                  = nil
    if @shop_order = Shop::Order.find_by(uuid: params[:id])

      if @shop_order.update(shop_order_params)
        StripeChargeJob.perform_later(@shop_order.uuid)
        render json: { uuid: @shop_order.uuid }
      else
        errors = @shop_order.errors.full_messages
        render json: {
                      error: errors.join(" ")
                      }, status: 400
      end
    else
      render json: {
                    error: 'Session expired, please reload page and try again'
                    }, status: 400
    end

  end
  
  # pulling status from _stripe_integration
  def payment_status
    @shop_order = Shop::Order.find_by(uuid: params[:uuid])
    render nothing: true, status: 404 and return unless @shop_order
    render json: {guid: @shop_order.uuid, status: @shop_order.state, error: @shop_order.error}
  end

  # DELETE /shop/orders/1
  # DELETE /shop/orders/1.json
  def destroy
    @shop_order.destroy
    respond_to do |format|
      format.html { redirect_to shop_orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_order_params
      params.require(:shop_order).permit(:user_id, 
                                         :stripe_customer_id, 
                                         :stripe_token, 
                                         :uuid, 
                                         :coupon_id,
                                         :email,
                                         :address_line_1,
                                         :address_line_2,
                                         :address_city,
                                         :address_country
                                         )
    end
end
