class User::PaymentMethodsController < ApplicationController
  before_action :access_user
  
  def edit
    @subscription = Subscription.cached_find(params[:id])
    @subscription.reset_state
    @plan         = @subscription.plan
    @months       = CreditCard.months
    @years        = CreditCard.years
  end
  
  def update
    
    
    subscription            =  Subscription.cached_find(params[:id])
    StripeUpdateCardJob.perform_later(subscription.guid, params[:stripeToken])
    
    render nothing: true
  end
  
  def status
    
    ap 'PaymentMethodsController#status'
    @subscription = Subscription.where(guid: params[:guid]).first
    puts '-------------------'
    ap @subscription.error
    puts '-------------------'
    ap @subscription.state
    #ap @sale
    render nothing: true, status: 404 and return unless @subscription
    render json: {guid: @subscription.guid, status: @subscription.state, error: @subscription.error}
  end
  
  def time_out
    @subscription = Subscription.where(guid: params[:guid]).first
    @subscription.reset_state
    render nothing: true
  end
  
  
  
protected


end
