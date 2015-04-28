class User::PaymentMethodsController < ApplicationController
  before_filter :access_user
  
  def edit
    @subscription = Subscription.cached_find(params[:id])
    @plan         = @subscription.plan
    build_cc_month
    build_cc_years
  end
  
  def update

    subscription   =  Subscription.cached_find(params[:id])
    subscription.update_cc!
    subscription.error = ''
    subscription.save
    StripeUpdateCardJob.perform_now(subscription.guid, params[:stripeToken])
    #redirect_to user_user_subscriptions_path( @user )
    render nothing: true
  end
  
  def status
    'PaymentMethodsController#status'
    @subscription = Subscription.where(guid: params[:guid]).first
    #ap @sale
    render nothing: true, status: 404 and return unless @subscription
    render json: {guid: @subscription.guid, status: @subscription.state, error: @subscription.error}
  end
  
  
  
protected

  
  def build_cc_month
    @months = []
    months = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"]
    months.each_with_index {|month, index| @months << "#{months[index]} (#{ format('%02d', index+1)})" }
  end

  def build_cc_years
    @years = *( Time.now.year.to_i.. Time.now.year.to_i+10 )
  end
end
