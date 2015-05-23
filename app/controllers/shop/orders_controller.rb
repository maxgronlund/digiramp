class Shop::OrdersController < ApplicationController
  #before_action :set_shop_order, only: [ :destroy]

  # GET /shop/orders
  # GET /shop/orders.json
  def index
    @shop_orders = Shop::Order.all
  end

  # GET /shop/orders/1
  # GET /shop/orders/1.json
  def show
    @user         = current_user
    @shop_order   = current_order
    @total_price  = @shop_order.total_price

    #@shop_order = Shop::Order.find_by(uuid: params[:id])
  end

  # GET /shop/orders/new
  def new
    @shop_order = Shop::Order.new
  end

  # GET /shop/orders/1/edit
  def edit
    @user         = current_user
    @shop_order   = current_order
    @total_price  = @shop_order.total_price
    @years        = CreditCard.years
    @months       = CreditCard.months
    
    
    
    
    
  end

  # POST /shop/orders
  # POST /shop/orders.json
  #def create
  #  @shop_order = Shop::Order.new(shop_order_params)
  #
  #  respond_to do |format|
  #    if @shop_order.save
  #      format.html { redirect_to @shop_order, notice: 'Order was successfully created.' }
  #      format.json { render :show, status: :created, location: @shop_order }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @shop_order.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /shop/orders/1
  # PATCH/PUT /shop/orders/1.json
  def update
    ap params
    
    #Stripe::Charge.create(
    #  :amount => 400,
    #  :currency => "dkk",
    #  :source => "tok_15wIE9DCWuUtTcRTsnmMpXmv", # obtained with Stripe.js
    #  :description => "Charge for test@example.com"
    #)
    

    #@plan           = Plan.find(params[:plan_id])
    #
    #if @user.email.blank?
    #  # sugger
    #  @user.email = params[:email]
    #  @user.save!
    #end

    #if coupon = Coupon.find_by( stripe_id: params[:coupon_code])
    #  subscription.coupon_code = coupon.stripe_object 
    #end
    
    #if subscription.save
    #  StripeChargerSubscriptionJob.perform_later(subscription.guid)
    #  render json: { guid: subscription.guid }
    #else
    #  ap '+ error +'
    #  ap subscription.errors.full_messages
    #  errors = subscription.errors.full_messages
    #  render json: { error: errors.join(" ") }, status: 400
    #end
    
    
    
    
    
    
    
    
    
    
    respond_to do |format|
      if @shop_order.update(shop_order_params)
        

        #Stripe::Charge.create(
        #  :amount => 400,
        #  :currency => "usd",
        #  :source => "tok_15wIE9DCWuUtTcRTsnmMpXmv", # obtained with Stripe.js
        #  :description => "Charge for test@example.com"
        #)
    

        
        
        #format.html { redirect_to @shop_order, notice: 'Order was successfully updated.' }
        format.html { redirect_to :back, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_order }
      else
        format.html { render :edit }
        render json: { error: errors.join(" ") }, status: 400
        #format.json { render json: @shop_order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def status
    ap '-------------- status -----------------------'
    @shop_order = Shop::Order.find_by(uuid: params[:id])
    #ap @sale
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
    # Use callbacks to share common setup or constraints between actions.
    #def set_shop_order
    #  @shop_order = Shop::Order.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_order_params
      params.require(:shop_order).permit(:user_id, :stripe_customer_id)
    end
end
