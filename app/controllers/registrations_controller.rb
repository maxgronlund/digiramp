class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  layout "application"
  # GET /registrations
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1
  def show
    @user = current_user
  end

  # GET /registrations/new
  def new
    #validates :full_name, :company, :email, :telephone, presence: true
    @registration = Registration.new(full_name: current_user.user_name, email: current_user.email, telephone: current_user.phone_number)
    @registration.build_card
    @account      = Account.cached_find( params[:account_id] )
    @user         = current_user
    @account_type = params[:account_type]
  end

  # POST /registrations
  def create
    @registration = Registration.new(registration_params)
    @registration.card.ip_address = request.remote_ip
    
    if @registration.save!

      case params['payment_method']
        when "paypal"
          redirect_to @registration.paypal_url(registration_path(@registration))
        when "card"
          if @registration.card.purchase
            ap registration_path(@registration)
            redirect_to registration_path(@registration), notice: @registration.card.card_transaction.message
          else
            registration_path(@registration)
            redirect_to registration_path(@registration), alert: @registration.card.card_transaction.message
          end
      end
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    puts 'hook'
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
      params.require(:registration).permit(:account_id, :full_name, :company, :email, :telephone,:address1, :city, :state, :country, :zip,
                                           card_attributes: [
                                               :first_name, :last_name, :card_type, :card_number,
                                               :card_verification, :card_expires_on])
    end
end
