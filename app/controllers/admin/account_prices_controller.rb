class Admin::AccountPricesController < ApplicationController
  before_action :set_account_price, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only
  # GET /account_prices
  # GET /account_prices.json
  def index
    @account_prices = AccountPrice.all
  end


  def show
  end


  def new
    @account_price = AccountPrice.new
  end


  def edit
  end


  #def create
  #  @account_price = AccountPrice.new(account_price_params)
  #
  #  respond_to do |format|
  #    if @account_price.save
  #      format.html { redirect_to @account_price, notice: 'Account price was successfully created.' }
  #      format.json { render :show, status: :created, location: @account_price }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @account_price.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /account_prices/1
  # PATCH/PUT /account_prices/1.json
  def update
     @account_price.update(account_price_params)
     
     
     
     accounts = Account.where(account_type: @account_price.account_type, special_subscription_fee: false)
     accounts.update_all(subscription_fee: @account_price.subscription_fee)
     
     redirect_to admin_account_prices_path
    #respond_to do |format|
    #  if @account_price.update(account_price_params)
    #    format.html { redirect_to @account_price, notice: 'Account price was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @account_price }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @account_price.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /account_prices/1
  # DELETE /account_prices/1.json
  def destroy
    @account_price.destroy
    respond_to do |format|
      format.html { redirect_to account_prices_url, notice: 'Account price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_price
      @account_price = AccountPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_price_params
      params.require(:account_price).permit(:subscription_fee, :account_type)
    end
end
