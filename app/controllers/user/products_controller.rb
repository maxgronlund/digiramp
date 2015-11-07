class User::ProductsController < ApplicationController
  before_action :access_user
  before_action :set_shop_product, only: [:show, :edit, :update, :destroy]
  

  # GET /shop/products
  # GET /shop/products.json
  def index
    redirect_to @user.is_stripe_connected ? user_user_shop_admin_index_path(@user) : user_user_create_shop_index_path(@user)
  end

  # GET /shop/products/1
  # GET /shop/products/1.json
  def show
    not_found unless @shop_product
    @order_items   = @shop_product.order_items.order('created_at desc').where(sold: true)

  end

  # GET /shop/products/new
  def new
    if params[:category].blank?
      redirect_to user_user_select_product_type_index_path(@user)
    else 
      @category     = params[:category]
      case params[:category] 
      when 'recording'
        additional_info = nil
        @recording      = nil
        
        @distribution_agreements = @user.distribution_agreements
        
        if params[:recording_id] 
          begin
            @recording          = Recording.cached_find(params[:recording_id])
            additional_info     = @recording.comment
            
            label           = @user.label
            label.default_distribution_agreement
            label_recording = LabelRecording.where(label_id: label.id, recording_id: @recording.id)
                                            .first_or_create(label_id: label.id, recording_id: @recording.id)
                                            
                                            
                                            
          rescue
            ErrorNotification.post("User::ProductsController#new recording_id: #{params[:recording_id]} not found")
          end
        end
        
        @shop_product = Shop::Product.new(
          price: 98, 
          additional_info: additional_info,
          for_sale: true,
          show_in_shop: true
          #distribution_agreement_id: @user.personal_distribution_agreement.id
        )
        
        get_documents
        
      when 'physical-product'
        @shop_product = Shop::Product.new(price: 98, 
                                          additional_info: additional_info,
                                          for_sale: true,
                                          show_in_shop: true)
        get_documents
      else
        redirect_to user_user_select_product_type_index_path(@user)
      end
    end
  end

  # GET /shop/products/1/edit
  def edit
    @category  = @shop_product.category
    @recording = @shop_product.productable_type == 'Recording' ?
                 @shop_product.productable :
                 nil
    get_documents
    
    #label           = @user.label
    #ap label.default_distribution_agreement
    #ap @user.distribution_agreements
    @distribution_agreements = @user.distribution_agreements
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
    ap params
    params[:shop_product][:connected_to_stripe] = @user.is_stripe_connected

    @shop_product = Shop::Product.new(shop_product_params)

    respond_to do |format|
      if @shop_product.save!
        @shop_product.configure_stakeholder
        @shop_product.valid_for_sale!
        
        # only aplies for recordings
        if @shop_product.distribution_agreement
          @shop_product.distribution_agreement.configure_payment( @shop_product.price, @shop_product.recording.id)
        end
        
        format.html { redirect_to user_user_product_path(@user, @shop_product) }
        format.json { render :show, status: :created, location: @shop_product }
      else
        # '=========================== do what you have to do here ============================='
        @category = 'recording' 
        format.html { render :new, category: 'recording' }
        format.json { render json: @shop_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop/products/1
  # PATCH/PUT /shop/products/1.json
  def update
    if Rails.env.development?
      ap @shop_product
    end
    @category     = @shop_product.category

    params[:shop_product][:connected_to_stripe] = @user.is_stripe_connected
    
    respond_to do |format|
      if @shop_product.update(shop_product_params)
        
        if Rails.env.development?
          ap @shop_product
        end
        
        case @shop_product.productable_type
          
        when "Recording"
          update_recording
        end
        #@shop_product.configure_stakeholder
        #@shop_product.valid_for_sale!
        
        #if distribution_agreement = @shop_product.distribution_agreement
        #  distribution_agreement.configure_payment( @shop_product.price, @shop_product.recording.id)
        #end
        
        
        
        
        #if @shop_product.productable_type == 'Recording'
        #  #@shop_product.recording.update_stakes( @shop_product.recording )
        #  SalesService.new(@shop_product.recording.id)
        #  
        #end
        #update_show_in_shop
        format.html { redirect_to user_user_product_path(@user, @shop_product) }

        #case @category
        #when 'recording'
        #  @recording = @shop_product.get_item
        #  
        #  if @recording.pre_cleared?
        #    after_update_path
        #    #session[:user_product_path] = nil
        #    #redirect_to user_user_product_path(@user, @shop_product)
        #  else
        #    session[:user_product_path] = user_user_product_path(@user, @shop_product)
        #    redirect_to user_user_common_work_path(@user, @recording.get_common_work) 
        #  end
        #else
        #  after_update_path
        #  #session[:user_product_path] = nil
        #  #redirect_to user_user_product_path(@user, @shop_product) 
        #end
        #end
        format.json { render :show, status: :ok, location: @shop_product }
      else
        format.html { render :edit }
        format.json { render json: @shop_product.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def update_recording
    
  end
  
  
  def after_update_path
    session[:user_product_path] = nil
    redirect_to user_user_product_path(@user, @shop_product)
  end

  # DELETE /shop/products/1
  # DELETE /shop/products/1.json
  # Never destroy, just put it aside
  def destroy

    @shop_product.user_id              = User.system_user.id
    @shop_product.account_id           = User.system_user.account.id
    @shop_product.for_sale             = false
    @shop_product.show_in_shop         = false
    @shop_product.connected_to_stripe  = false
    @shop_product.save
    @shop_product.stakeholders.destroy_all
    @shop_product.productable.update(in_shop: false) if @shop_product.productable

    Shop::OrderItem.where(sold: false, shop_product_id: @shop_product.id).destroy_all
    
    respond_to do |format|
      format.html { redirect_to user_user_shop_admin_index_path(@user) }
      format.json { head :no_content }
    end
  end

  private
  
  #def set_productable params
  #  if recording_id = params[:shop_product][:recording_id]
  #    params[:shop_product][:productable_id]    = recording_id
  #    params[:shop_product][:productable_type]  = 'Recording'  
  #    @recording = Recording.cached_find(recording_id)
  #    params[:shop_product][:valid_for_sale]    = @recording.is_cleared?
  #  else
  #    params[:shop_product][:productable_type]  = 'Physical product'  
  #    params[:shop_product][:valid_for_sale]    = true
  #  end
  #end
  

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
