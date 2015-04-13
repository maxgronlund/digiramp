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
      @invoice        = 'INVOICE' + @notification_params["invoice"].to_s
      @full_name      = @notification_params["first_name"].to_s
      @full_name      << ' ' + @notification_params["last_name"].to_s
      @quantity       = @notification_params["quantity"]
      @mc_gross       = @notification_params["mc_gross"]
      @payment_gross  = @notification_params["payment_gross"]
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
    
    @account      = @user.account
    
    # the account is expired update from today
    if @account.expiration_date <= Date.today
      expiration_date = Date.today + 1.months
    
    # the acconunt is not expired update from last registrations expiration date
    elsif last_registration = @account.registrations.last
      expiration_date =  last_registration.expiration_date + 1.months
    
    # the account is not expired and there is no previous registrations so update from expiration date
    else
      expiration_date = @account.expiration_date + 1.months
    end

    if @account_features = AccountFeature.where(account_type: params[:account_type]).first

      #validates :full_name, :company, :email, :telephone, presence: true
      @registration = Registration.new( full_name:          current_user.user_name, 
                                        email:              current_user.email, 
                                        telephone:          current_user.phone_number,
                                        account_type:       @account_features.account_type,
                                        description:        @account_features.description,
                                        subscription_fee:   @account_features.subscription_fee,
                                        quantity:           1,
                                        expiration_date:    expiration_date,
                                        status:             'Pending'
                                        )
      @registration.build_card
      
    else
      redirect_to user_user_plans_path(@user)
    end
  end

  # POST /registrations
  def create
    @registration                 = Registration.new(registration_params)
    @registration.card.ip_address = request.remote_ip
    if @registration.save!
      
      case params['payment_method']
        when "paypal"
          # approve from hook callback
          redirect_to @registration.paypal_url(user_user_registration_path(@user, @registration) )
        when "card"
          if @registration.card.purchase
            # approved here
            redirect_to user_user_registrations_path(@user), notice: @registration.card.card_transaction.message
          else
            # fail try again
            account_type = @registration.account_type
            @registration.destroy
            redirect_to new_user_user_registration_path(@user, account_type: account_type), alert: @registration.card.card_transaction.message
            
          end
      end
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook, :show]
  def hook
    ap '------------ hook ------------'
    # sugestion send invoice as pdf
    # notify in notification center
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @registration = Registration.find( params[:invoice].to_i - 22345 )
      @registration.update_attributes( notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now )
      @registration.account.update_expiration_date
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
                                           :expiration_date,
                                           :quantity,
                                           card_attributes: [
                                               :first_name, :last_name, :card_type, :card_number,
                                               :card_verification, :card_expires_on])
    end
end
