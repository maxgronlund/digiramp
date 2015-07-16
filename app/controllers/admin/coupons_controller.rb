class Admin::CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.order('created_at desc').where(sales_coupon_batch_id: nil)
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new(redeem_by: Date.today + 3.month)
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      #if error = @coupon.push_to_stripe[:error]
      #  #  flash[:danger] = e.message 
      #  ap '-------------- error ---------------------'
      #  Opbeat.capture_message("Admin::CouponsController#create")
      #  #flash[:danger] = error if error
      #  @coupon.destroy
      #end
      #redirect_to admin_coupons_path
      unless Rails.env.test?
        begin
          Stripe::Coupon.create(
            id:                   @coupon.stripe_id,
            amount_off:           @coupon.amount_off.to_i  <= 0 ? nil : @coupon.amount_off,
            percent_off:          @coupon.percent_off.to_i <= 0 ? nil : @coupon.percent_off,
            duration:             @coupon.duration,
            duration_in_months:   @coupon.duration_in_months.to_i <= 0 ? nil : @coupon.duration_in_months,
            currency:             @coupon.currency,
            max_redemptions:      @coupon.max_redemptions.to_i <= 0 ? nil : @coupon.max_redemptions,
            redeem_by:            @coupon.redeem_by.nil? ? nil : Time.parse(@coupon.redeem_by.to_s).to_i
          )
          redirect_to admin_coupons_path
        rescue Stripe::StripeError => e
          flash[:danger] = e.message 
          @coupon.destroy
          redirect_to new_admin_coupon_path
        end
      else
        redirect_to admin_coupons_path
      end

    else
      render :new
    end
  
  end
  

  # Time.parse(@coupon.redeem_by).to_i
  
  
  

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path
    else
      render :edit
    end
      
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    redirect_to_return_url admin_coupons_path
    #redirect_to admin_coupons_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit( :amount_off,
                                      :percent_off, 
                                      :duration, 
                                      :duration_in_months, 
                                      :stripe_id, 
                                      :currency, 
                                      :max_redemptions, 
                                      :times_redeemed,
                                      :metadata, 
                                      :redeem_by, 
                                      :user_id, 
                                      :account_id,
                                      :plan_id)
    end
end
