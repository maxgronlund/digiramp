class Sales::CouponBatchesController < Sales::SalesController
  before_action :set_sales_coupon_batch, only: [:show, :edit, :update, :destroy]

  # GET /sales/coupon_batches
  # GET /sales/coupon_batches.json
  def index
    @sales_coupon_batches = Sales::CouponBatch.all
  end

  # GET /sales/coupon_batches/1
  # GET /sales/coupon_batches/1.json
  def show
  end

  # GET /sales/coupon_batches/new
  def new
    @sales_coupon_batch = Sales::CouponBatch.new( redeem_by: Date.today + 3.month)
  end

  # GET /sales/coupon_batches/1/edit
  def edit
  end

  # POST /sales/coupon_batches
  # POST /sales/coupon_batches.json
  def create
    
    params[:sales_coupon_batch][:user_id]     = current_user.id
    params[:sales_coupon_batch][:account_id]  = current_user.account_id
    params[:sales_coupon_batch][:created_by]  = current_user.email
    
    
    @sales_coupon_batch = Sales::CouponBatch.new(sales_coupon_batch_params)

    respond_to do |format|
      if @sales_coupon_batch.save!
        
        CouponBatchService.call( params, @sales_coupon_batch.id)
        format.html { redirect_to edit_sales_coupon_batch_path(@sales_coupon_batch), notice: 'Coupon batch was successfully created.' }
        format.json { render :show, status: :created, location: @sales_coupon_batch }
      else
        format.html { render :new }
        format.json { render json: @sales_coupon_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/coupon_batches/1
  # PATCH/PUT /sales/coupon_batches/1.json
  def update
   
    #@sales_coupon_batch.email     = params[:sales_coupon_batch][:email]
    #@sales_coupon_batch.subject   = params[:sales_coupon_batch][:subject]
    #@sales_coupon_batch.body      = params[:sales_coupon_batch][:body]
    
    respond_to do |format|
      
      if @sales_coupon_batch.update!(sales_coupon_batch_params)
        
        
        
        image =  File.open(Rails.root.join('app', 'assets', 'images', "coupon-code.jpg"))
        
        product_params = {  title:                         @sales_coupon_batch.title, 
                            body:                          @sales_coupon_batch.body, 
                            additional_info:               @sales_coupon_batch.body, 
                            price:                         @sales_coupon_batch.total_price,
                            exclusive_offered_to_email:    @sales_coupon_batch.email,
                            download_link:                 @sales_coupon_batch.uuid,
                            user_id:                       @sales_coupon_batch.user_id,
                            account_id:                    @sales_coupon_batch.account_id,
                            units_on_stock:                1,
                            for_sale:                      true,
                            image:                         image,
                            download_link:                 @sales_coupon_batch.uuid
                          }
        
        Shop::Product.attach(@sales_coupon_batch, product_params)
        
        #@sales_coupon_batch.attach_to_product
        
        CouponBatchMailer.delay.send_coupon_offer(@sales_coupon_batch.id) 
        
        format.html { redirect_to edit_sales_coupon_batch_path(@sales_coupon_batch), notice: "Special offer is send to #{@sales_coupon_batch.email}" }
        format.json { render :edit, status: :ok, location: @sales_coupon_batch }
      else
        format.html { render :edit }
        format.json { render json: @sales_coupon_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/coupon_batches/1
  # DELETE /sales/coupon_batches/1.json
  def destroy
    @sales_coupon_batch.destroy
    respond_to do |format|
      format.html { redirect_to sales_coupon_batches_url, notice: 'Coupon batch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sales_coupon_batch
    @sales_coupon_batch = Sales::CouponBatch.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def sales_coupon_batch_params
    if can_sell?
      params.require(:sales_coupon_batch).permit( :title,
                                                 :body,
                                                 :email,
                                                 :created_by,        
                                                 :discount,
                                                 :sold,
                                                 :uuid,
                                                 :subject,
                                                 :download_uuid,
                                                 :total_price,        
                                                 :stripe_id,
                                                 :amount_off,
                                                 :percent_off,
                                                 :duration,
                                                 :duration_in_months,
                                                 :currency,
                                                 :number_of_coupons,
                                                 :times_redeemed,
                                                 :metadata,
                                                 :plan_id,
                                                 :account_id,
                                                 :redeem_by,
                                                 :original_price,    
                                                 :product_uuid,
                                                 :user_id )
      
      
    end
  end
end
