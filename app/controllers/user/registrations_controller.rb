class User::RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_filter :access_user, only: [:show, :new, :create, :index]
  layout "registrations", only: [:show]
  # GET /registrations
  def index
    @registrations = @user.account.registrations.order('id desc')
  end

  # GET /registrations/1
  #def show
  #  @user = current_user
  #  
  #  
  #end
  def show
    #ap params
    #ap @user
    #@user = current_user
    
    if @notification_params = @registration.notification_params
      @invoice    = 'INVOICE' + @notification_params["invoice"].to_s
      @full_name  = @notification_params["first_name"].to_s
      @full_name << ' ' + @notification_params["last_name"].to_s
      @payment_gross  = @notification_params["payment_gross"]
      @quantity       = @notification_params["quantity"]
      @mc_gross       = @notification_params["mc_gross"]
    end
    #render( pdf: @registration.id.to_s, :layout => 'registrations')   # Excluding ".pdf" extension.
    respond_to do |format|
      format.html do
        render( pdf: 'DigiRAMP-subscription-invoice' + @invoice, :layout => 'registrations')   # Excluding ".pdf" extension.
      end
      format.pdf do
        render( pdf: 'DigiRAMP-subscription-invoice' + @invoice, :layout => 'registrations')   # Excluding ".pdf" extension.
      end
    end
  end

  # GET /registrations/new
  def new

    unless @account_features = AccountFeature.where(account_type: params[:account_type]).first
      redirect_to user_user_plans_path(@user)
    end
    ap @account_features
    #validates :full_name, :company, :email, :telephone, presence: true
    @registration = Registration.new( full_name:          current_user.user_name, 
                                      email:              current_user.email, 
                                      telephone:          current_user.phone_number,
                                      account_type:       @account_features.account_type,
                                      description:        @account_features.description,
                                      subscription_fee:   @account_features.subscription_fee
                                      )
    @registration.build_card
    @account      = @user.account
    
  end

  # POST /registrations
  def create
   
    @registration = Registration.new(registration_params)
    @registration.card.ip_address = request.remote_ip
    
    if @registration.save!
      #ap @registration
      case params['payment_method']
        when "paypal"
          redirect_to @registration.paypal_url(user_user_registration_path(@user, @registration))
          #ap params
          #redirect_to @registration.paypal_url(payments_path)
        when "card"
          if @registration.card.purchase
            redirect_to user_user_registration_path(@user, @registration), notice: @registration.card.card_transaction.message
          else
            # do something else here
            redirect_to user_user_registration_path(@user, @registration), alert: @registration.card.card_transaction.message
            
          end
      end
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook, :show]
  def hook
    # sugestion send invoice as pdf
    # notify in notification center
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @registration = Registration.find( params[:invoice].to_i - 12345 )
      @registration.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:account_id, 
                                           :full_name, 
                                           :company, 
                                           :email, 
                                           :telephone, 
                                           :address1, 
                                           :city, 
                                           :state, 
                                           :country, 
                                           :zip, 
                                           :account_type,
                                           :description,
                                           :subscription_fee,
                                           card_attributes: [
                                               :first_name, :last_name, :card_type, :card_number,
                                               :card_verification, :card_expires_on])
    end
end
