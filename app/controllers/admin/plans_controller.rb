class Admin::PlansController < ApplicationController
  before_action :admin_only
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  


  def index
    @plans = Plan.all
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    
    @plan = Plan.new(plan_params)
    
    if @plan.save
      begin
        Stripe::Plan.create( id:                    @plan.stripe_id,
                             amount:                @plan.amount,
                             currency:              @plan.currency,
                             interval:              @plan.interval,
                             name:                  @plan.name,
                             trial_period_days:     @plan.trial_period_days,
                             statement_descriptor:  @plan.statement_descriptor
                             )
        redirect_to admin_plans_path
      rescue Stripe::StripeError => e
        flash[:danger] = e.message 
        @plan.destroy
        redirect_to new_admin_plan_path
      end
    else
      
      redirect_to new_admin_plan_path
    end

  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    
    if @plan.update!(plan_params)
      begin
        statement_descriptor      = @plan.statement_descriptor == '' ? nil : @plan.statement_descriptor
        
        plan                      = Stripe::Plan.retrieve(@plan.stripe_id)
        plan.name                 = @plan.name
        plan.statement_descriptor = @plan.statement_descriptor

        plan.save
        redirect_to admin_plans_path
      rescue Stripe::StripeError => e
        flash[:danger] = e.message 
        ErrorNotification.post e.message 
        redirect_to edit_admin_plan_path
      end
    else
      flash[:danger] = e.message 
      redirect_to edit_admin_plan_path( @plan )
    end
      

  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    begin
      plan = Stripe::Plan.retrieve(@plan.stripe_id)
      plan.delete

    rescue Stripe::StripeError => e
      flash[:danger] = e.message 
    end
    @plan.destroy
    redirect_to admin_plans_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:stripe_id, :name, :description, :amount, :interval, :published, :currency, :trial_period_days, :statement_descriptor, :metadata, :account_type)
    end
end
