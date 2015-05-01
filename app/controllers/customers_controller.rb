class CustomersController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  before_action :set_account_user, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    #@customers = Customer.all
    @account_users = AccountUser.account_search(@account, params[:query]).order('lower(name) ASC').page(params[:page]).per(14)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    
  end

  # GET /customers/new
  def new
    @account_user = AccountUser.new
  end

  # GET /customers/1/edit
  def edit
    
    
  end

  # POST /customers
  # POST /customers.json
  def create
    
    params[:account_user][:role] = "Client"
    
    
    unless @account_user = AccountUser.where(email: params[:account_user][:email], account_id: @account.id ).first
       @account_user =  AccountUser.create( email: params[:account_user][:email], 
                                           name: params[:account_user][:name], 
                                           role: 'Client', 
                                           account_id: @account.id, 
                                           user_id: -1)
       @account_user.mount_user
      end
      
    
    if @account_user
      flash[:info] = "A new customer is added to your account" 
    else
      flash[:danger] = "User is already added to account" 
    end
    @account.customer_cache_version += 1
    
    redirect_to new_account_customer_customer_event_path( @account, @account_user)
    
  end

  def update
    @account_user.update_attributes(account_user_params)
    @account.customer_cache_version += 1
    @account.save!
    redirect_to account_customer_path( @account, @account_user )
  end

  def destroy
    user = @account_user.user
    
    if user.id == @account.user_id
      flash[:danger] =  "Unable to delete account owner" 
    else
      @account_user.destroy
      @account.customer_cache_version += 1
      @account.save!
      if user && user.activated == false && user.account_users.size
        user.destroy
      end
    end
    redirect_to account_customers_path( @account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_user
      @account_user = AccountUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_user_params
      params.require(:account_user).permit!
    end
end
