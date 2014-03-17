class CustomersController < ApplicationController
  before_filter :there_is_access_to_the_account
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.save!
    @account.customer_cache_version += 1
    @account.save!
    redirect_to account_customers_path @account
    
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @customer.update_attributes(customer_params)
    @account.customer_cache_version += 1
    @account.save!
    redirect_to account_customer_path( @account, @customer )
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    
    @customer.destroy
    @account.customer_cache_version += 1
    @account.save!
    redirect_to account_customers_path @account
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :email, :phone, :note, :account_id)
    end
end
