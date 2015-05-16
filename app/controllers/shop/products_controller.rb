class Shop::ProductsController < ApplicationController
  before_action :set_shop_product, only: [:show, :edit, :update, :destroy]

  # GET /shop/products
  # GET /shop/products.json
  def index
    @shop_products = @user.products
  end

  # GET /shop/products/1
  # GET /shop/products/1.json
  def show
  end

  # GET /shop/products/new
  def new
    @shop_product = Shop::Product.new
  end

  # GET /shop/products/1/edit
  def edit
  end

  # POST /shop/products
  # POST /shop/products.json
  def create
    @shop_product = Shop::Product.new(shop_product_params)

    respond_to do |format|
      if @shop_product.save
        format.html { redirect_to @shop_product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @shop_product }
      else
        format.html { render :new }
        format.json { render json: @shop_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop/products/1
  # PATCH/PUT /shop/products/1.json
  def update
    respond_to do |format|
      if @shop_product.update(shop_product_params)
        format.html { redirect_to @shop_product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_product }
      else
        format.html { render :edit }
        format.json { render json: @shop_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop/products/1
  # DELETE /shop/products/1.json
  def destroy
    @shop_product.destroy
    respond_to do |format|
      format.html { redirect_to shop_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_product
      @shop_product = Shop::Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_product_params
      params.require(:shop_product).permit(:title, :body, :additionl_info, :image, :price, :user_id, :account_id, :download_link, :for_sale)
    end
end
