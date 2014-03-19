class CustomerEventsController < ApplicationController
  before_filter :there_is_access_to_the_account
  before_action :set_customer_event, only: [:show, :edit, :update, :destroy]

  # GET /customer_events
  # GET /customer_events.json
  def index
    @customer_events = CustomerEvent.all
  end

  # GET /customer_events/1
  # GET /customer_events/1.json
  def show
  end

  # GET /customer_events/new
  def new
    @account_user       = AccountUser.find_by_cached_id(params[:customer_id])
    @customer_event     = CustomerEvent.new
  end

  # GET /customer_events/1/edit
  def edit
  end

  # POST /customer_events
  # POST /customer_events.json
  def create
    @account_user     = AccountUser.find_by_cached_id(params[:customer_id])
    @customer_event   = CustomerEvent.create(customer_event_params)

    redirect_to account_customer_path(@account, @account_user)
    
  end

  # PATCH/PUT /customer_events/1
  # PATCH/PUT /customer_events/1.json
  def update
    
  end

  # DELETE /customer_events/1
  # DELETE /customer_events/1.json
  def destroy
    @customer_event.destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_event
      @customer_event = CustomerEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_event_params
      params.require(:customer_event).permit!
    end
end
