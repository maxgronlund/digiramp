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
   
  end

  # GET /shop/stripe_transfers/1/edit
  def edit
  end

  # POST /shop/stripe_transfers
  # POST /shop/stripe_transfers.json
  def create
    
  end

  # PATCH/PUT /shop/stripe_transfers/1
  # PATCH/PUT /shop/stripe_transfers/1.json
  def update
    
  end

  # DELETE /shop/stripe_transfers/1
  # DELETE /shop/stripe_transfers/1.json
  def destroy
   
  end

  private
  
end
