class Shop::PhysicalProductsController < ApplicationController
  before_action :set_shop_physical_product, only: [:show, :edit, :update, :destroy]

  # GET /shop/physical_products
  # GET /shop/physical_products.json
  def index
    @shop_physical_products = Shop::PhysicalProduct.all
  end

  # GET /shop/physical_products/1
  # GET /shop/physical_products/1.json
  def show
  end

  # GET /shop/physical_products/new
  def new
    @shop_physical_product = Shop::PhysicalProduct.new
  end

  # GET /shop/physical_products/1/edit
  def edit
  end

  # POST /shop/physical_products
  # POST /shop/physical_products.json
  def create
    @shop_physical_product = Shop::PhysicalProduct.new(shop_physical_product_params)

    respond_to do |format|
      if @shop_physical_product.save
        format.html { redirect_to @shop_physical_product, notice: 'Physical product was successfully created.' }
        format.json { render :show, status: :created, location: @shop_physical_product }
      else
        format.html { render :new }
        format.json { render json: @shop_physical_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop/physical_products/1
  # PATCH/PUT /shop/physical_products/1.json
  def update
    respond_to do |format|
      if @shop_physical_product.update(shop_physical_product_params)
        format.html { redirect_to @shop_physical_product, notice: 'Physical product was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_physical_product }
      else
        format.html { render :edit }
        format.json { render json: @shop_physical_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/physical_products/1
  # DELETE /shop/physical_products/1.json
  def destroy
    @shop_physical_product.destroy
    respond_to do |format|
      format.html { redirect_to shop_physical_products_url, notice: 'Physical product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_physical_product
      @shop_physical_product = Shop::PhysicalProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_physical_product_params
      params.require(:shop_physical_product).permit(:dimensions, :waight, :shipping_cost, :units_on_stock)
    end
end
