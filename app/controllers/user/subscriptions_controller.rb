class User::SubscriptionsController < ApplicationController
  before_filter :access_user
  before_filter :load_plans
  
 
  def index
    if account = @user.account
      # can be nil
      @current_plan         = account.current_plan
      @current_subscription = account.current_subscription
    end
    
    @account_features     =  AccountFeature.order(:position).where(enabled: true)
  end
  
  def show
    
  end
  
  def new
    build_cc_month
    build_cc_years

    @account              = @user.account
    @subscription         = Subscription.new
    if @account_features  = AccountFeature.where(account_type: params[:account_type]).first
      @plan               = @account_features.plan
    else
      flash[:danger] = 'Plan is missing'
    end

  end
  
  def create

    @plan           = Plan.find(params[:plan_id])
    
    if @user.email.blank?
      @user.email = params[:email_address]
      @user.save!
    end

    
    subscription    = Subscription.new( plan_id:          @plan.id, 
                                        user_id:          @user.id,
                                        #email_address:    params[:email_address],
                                        stripe_token:     params[:stripeToken],
                                        account_id:       @user.account_id,
                                        guid:             UUIDTools::UUID.timestamp_create().to_s,
                                        #month:           0,
                                        account_type:     @plan.name,
                                        cardholders_name: params[:cardholders_name]
                                       )
    
    if subscription.save
      StripeChargerSubscriptionJob.perform_later(subscription.guid)
      render json: { guid: subscription.guid }
    else
      ap 'error +'
      errors = subscription.errors.full_messages
      render json: { error: errors.join(" ") }, status: 400
    end
    
  end
  
  def edit

    @subscription       =  Subscription.cached_find(params[:id])
    redirect_to edit_user_user_payment_method_path(@user, @subscription) if params[:update_payment_method]
    @account_features   =  AccountFeature.order(:position).where(enabled: true)
    #if account = @user.account
    #  @current_subscription = account.current_subscription
    #end
  end
  
  def update

    @subscription       =  Subscription.cached_find(params[:id])

    if plan = params[:plan_id] && Plan.where(id: params[:plan_id]).first

      msg = @subscription.change_plan(plan.id)
      if msg
        flash[:danger] = msg
      else
        flash[:info] = "Your will receive an email in a few minutes when your plan has changed" 
      end
    else
      # this is a 'social' plan or a plan without a stripe connection
      
      @subscription.cancel_when_plan_expires
    end
    
    redirect_to user_user_control_panel_index_path(@user)
  end
  
  def status
    @subscription = Subscription.where(guid: params[:guid]).first
    #ap @sale
    render nothing: true, status: 404 and return unless @subscription
    render json: {guid: @subscription.guid, status: @subscription.state, error: @subscription.error}
  end
  
  protected
    def load_plans
      @plans = Plan.where(published: true).order('amount')
    end
    
    def build_cc_month
      @months = []
      months = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"]
      months.each_with_index {|month, index| @months << "#{months[index]} (#{ format('%02d', index+1)})" }
    end
  
    def build_cc_years
      @years = *( Time.now.year.to_i.. Time.now.year.to_i+10 )
    end
end