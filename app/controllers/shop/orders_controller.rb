class Shop::OrdersController < ApplicationController
  before_action :set_shop_order, only: [:show, :edit, :update, :destroy]

  # GET /shop/orders
  # GET /shop/orders.json
  def index
    @shop_orders = Shop::Order.all
  end

  # GET /shop/orders/1
  # GET /shop/orders/1.json
  def show
  end

  # GET /shop/orders/new
  def new
    @shop_order = Shop::Order.new
  end

  # GET /shop/orders/1/edit
  def edit
  end

  # POST /shop/orders
  # POST /shop/orders.json
  def create
    @shop_order = Shop::Order.new(shop_order_params)

    respond_to do |format|
      if @shop_order.save
        format.html { redirect_to @shop_order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @shop_order }
      else
        format.html { render :new }
        format.json { render json: @shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop/orders/1
  # PATCH/PUT /shop/orders/1.json
  def update
    respond_to do |format|
      if @shop_order.update(shop_order_params)
        format.html { redirect_to @shop_order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_order }
      else
        format.html { render :edit }
        format.json { render json: @shop_order.errors, status: :unprocessable_entity }
      end
    end
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
    def set_shop_order
      @shop_order = Shop::Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_order_params
      params.require(:shop_order).permit(:user_id, :stripe_customer_id)
    end
end
