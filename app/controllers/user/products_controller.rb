class User::ProductsController < ApplicationController
  before_action :access_user
  before_action :set_shop_product, only: [:show, :edit, :update, :destroy]
  
  

  # GET /shop/products
  # GET /shop/products.json
  def index
    @shop_products = Shop::Product.all
    
  end

  # GET /shop/products/1
  # GET /shop/products/1.json
  def show
    not_found unless @shop_product
    @order_items = @shop_product.order_items.order('created_at desc').where(sold: true)
    #@shop_order = current_order
  end

  # GET /shop/products/new
  def new
    @shop_product = Shop::Product.new
    @category     = params[:category]
   get_documents
  end

  # GET /shop/products/1/edit
  def edit
    @category = @shop_product.category
    get_documents
    
  end
  
  def get_documents
    case @category
    when 'recording'
      @documents = @user.account.documents.where(tag: 'Recording', document_type: 'Legal')
    when 'physical-product'
      @documents = @user.account.documents.where(tag: 'Physical product', document_type: 'Legal')
    end

  end
  
  

  # POST /shop/products
  # POST /shop/products.json
  def create
    @shop_product = Shop::Product.new(shop_product_params)

    respond_to do |format|
      if @shop_product.save
        format.html { redirect_to user_user_product_path(@user, @shop_product.uuid) }
        format.json { render :show, status: :created, location: @shop_product }
      else
        ap '=========================== do what you have to do here ============================='
        format.html { render :new, category: 'recording' }
        format.json { render json: @shop_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop/products/1
  # PATCH/PUT /shop/products/1.json
  def update
    @category     = @shop_product.category
    
    
    
    
    respond_to do |format|
      if @shop_product.update(shop_product_params)
        #ap @shop_product
        #update_show_in_shop
        format.html do 
        case @category
        when 'recording'
          @recording = @shop_product.recording
          
          if @recording.pre_cleared?
            after_update_path
            #session[:user_product_path] = nil
            #redirect_to user_user_product_path(@user, @shop_product.uuid)
          else
            session[:user_product_path] = user_user_product_path(@user, @shop_product.uuid)
            redirect_to user_user_common_work_path(@user, @recording.common_work) 
          end
        else
          after_update_path
          #session[:user_product_path] = nil
          #redirect_to user_user_product_path(@user, @shop_product.uuid) 
        end
        end
        format.json { render :show, status: :ok, location: @shop_product }
      else
        format.html { render :edit }
        format.json { render json: @shop_product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def after_update_path
    session[:user_product_path] = nil
    redirect_to user_user_product_path(@user, @shop_product.uuid)
  end

  # DELETE /shop/products/1
  # DELETE /shop/products/1.json
  # Never destroy, just put it aside
  def destroy

    @shop_product.user_id       = User.system_user
    @shop_product.account_id    = User.system_user.account.id
    @shop_product.for_sale      = false
    @shop_product.show_in_shop  = false
    @shop_product.save
    
    respond_to do |format|
      format.html { redirect_to user_user_shop_admin_index_path(@user) }
      format.json { head :no_content }
    end
  end

  private
  
   # Use callbacks to share common setup or constraints between actions.
  def set_shop_product
    @shop_product = Shop::Product.cached_find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def shop_product_params
    if super? || current_user.id == @user.id
    params.require(:shop_product).permit( ProductParams::PARAMS )
    end
  end

    
  #def update_show_in_shop
  #  # only make additional checks if the product is for sale
  #  if @shop_product.show_in_shop = @shop_product.for_sale
  #    # don't show exclucive offers in the shop
  #    unless @shop_product.exclusive_offered_to_email.blank?
  #      # this is a exclucive offer
  #      @shop_product.show_in_shop = false
  #    end
  #    # don't show the product if the units is limited and there is nothing left
  #    if @shop_product.units_on_stock &&  @shop_product.units_on_stock < 1
  #      # out of stock
  #      @shop_product.show_in_shop = false
  #    end
  #  end
  #  @shop_product.save
  #end
  
end
