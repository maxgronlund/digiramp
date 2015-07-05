class Shop::StripeTransfersController < ApplicationController
  before_action :set_shop_stripe_transfer, only: [:show, :edit, :update, :destroy]

  # GET /shop/stripe_transfers
  # GET /shop/stripe_transfers.json
  def index
    @shop_stripe_transfers = Shop::StripeTransfer.all
  end

  # GET /shop/stripe_transfers/1
  # GET /shop/stripe_transfers/1.json
  def show
  end

  # GET /shop/stripe_transfers/new
  def new
    @shop_stripe_transfer = Shop::StripeTransfer.new
  end

  # GET /shop/stripe_transfers/1/edit
  def edit
  end

  # POST /shop/stripe_transfers
  # POST /shop/stripe_transfers.json
  def create
    @shop_stripe_transfer = Shop::StripeTransfer.new(shop_stripe_transfer_params)

    respond_to do |format|
      if @shop_stripe_transfer.save
        format.html { redirect_to @shop_stripe_transfer, notice: 'Stripe transfer was successfully created.' }
        format.json { render :show, status: :created, location: @shop_stripe_transfer }
      else
        format.html { render :new }
        format.json { render json: @shop_stripe_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop/stripe_transfers/1
  # PATCH/PUT /shop/stripe_transfers/1.json
  def update
    respond_to do |format|
      if @shop_stripe_transfer.update(shop_stripe_transfer_params)
        format.html { redirect_to @shop_stripe_transfer, notice: 'Stripe transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_stripe_transfer }
      else
        format.html { render :edit }
        format.json { render json: @shop_stripe_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/stripe_transfers/1
  # DELETE /shop/stripe_transfers/1.json
  def destroy
    @shop_stripe_transfer.destroy
    respond_to do |format|
      format.html { redirect_to shop_stripe_transfers_url, notice: 'Stripe transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_stripe_transfer
      ap '=============================   NEVER USED ================================================'
      @shop_stripe_transfer = Shop::StripeTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_stripe_transfer_params
      params.require(:shop_stripe_transfer).permit(:shop_order_item_id, :shop_order_id, :user_id, :split, :due_date)
    end
end
