class User::RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :access_user, only: [:show, :new, :create, :index]
  #layout "registrations", only: [:show]
  # GET /registrations
  
  before_action :obsolete
  
  def obsolete
    # '===================================================='
    # '===================================================='
    # '        User::RegistrationsController               '
    # '      !!! PAYPAL NO LONGER SUPPORTED                '
    # '===================================================='
    # '===================================================='
    
  end
  
  def index
    #@registrations = @user.account.registrations.order('id desc')
  end


  def show
  
   
  end
  


  # GET /registrations/new
  def new
    
  end

  # POST /registrations
  def create
    
  end

  protect_from_forgery except: [:hook, :show]
  def hook
    
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
