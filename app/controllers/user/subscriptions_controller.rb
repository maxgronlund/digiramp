class User::SubscriptionsController < ApplicationController
  before_action :access_user
  before_action :load_plans
  
 
  def index
    if account = @user.account
      # can be nil
      @current_plan         = account.current_plan
      @current_subscription = account.current_subscription
    end
    
    @account_features     =  AccountFeature.order(:position).where(enabled: true)
  end
  
  #def show
  #  
  #end
  
  def new
    @months = CreditCard.months
    @years  = CreditCard.years

    @account              = @user.account
    @subscription         = Subscription.new(email: @user.email)
    if @account_features  = AccountFeature.where(account_type: params[:account_type]).first
      @plan               = @account_features.plan
    else
      flash[:danger] = 'Plan is missing'
    end

  end
  
  def create
   
    @plan           = Plan.find(params[:plan_id])
    
    if @user.email.blank?
      # sugger
      @user.email = params[:email]
      @user.save!
    end

    subscription    = Subscription.new( plan_id:          @plan.id, 
                                        user_id:          @user.id,
                                        account_id:       @user.account_id,
                                        email:            params[:email],
                                        stripe_token:     params[:stripeToken],
                                        guid:             UUIDTools::UUID.timestamp_create().to_s,
                                        cardholders_name: params[:cardholders_name],
                                        coupon_code:      params[:coupon_code]
                                       )
    
    #if coupon = Coupon.find_by( stripe_id: params[:coupon_code])
    #  subscription.coupon_code = coupon.stripe_object 
    #end
    
    if subscription.save
      StripeChargerSubscriptionJob.perform_later(subscription.guid)
      render json: { guid: subscription.guid }
    else
      ap '+ error +'
      ap subscription.errors.full_messages
      errors = subscription.errors.full_messages
      render json: { error: errors.join(" ") }, status: 400
    end
    
  end
  
  def edit
    #ap 'user/subscriptions_controller # edit'
    @subscription       =  Subscription.cached_find(params[:id])
    redirect_to edit_user_user_payment_method_path(@user, @subscription) if params[:update_payment_method]
    @account_features   =  AccountFeature.order(:position).where(enabled: true)
    #if account = @user.account
    #  @current_subscription = account.current_subscription
    #end
  end
  
  def time_out
    @subscription       =  Subscription.cached_find(params[:id])
    @subscription.fail!
  end
  
  def update
    #ap 'user/subscriptions_controller # update'
    #ap params
    @subscription       = Subscription.cached_find(params[:id])
    flash[:warning]     = @subscription.change_plan(params[:plan_id])

    #if plan = Plan.cached_find(params[:plan_id])
    #  msg = @subscription.change_plan(params[:plan_id].id)
    #  if msg
    #    flash[:warning] = @subscription.change_plan(params[:plan_id].id)
    #  else
    #    flash[:info] = "Your will receive an email in a few minutes when your plan has changed" 
    #  end
    #else
    #  
    #end
    #
    redirect_to user_user_control_panel_index_path(@user)
  end
  
  def destroy
    #ap 'user/subscriptions_controller # destroy'
    @subscription       =  Subscription.cached_find(params[:id])
    # this is a 'social' plan or a plan without a stripe connection
    flash[:info] =  @subscription.cancel_when_plan_expires

    redirect_to user_user_subscriptions_path(@user)
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
    

end