class User::PaymentMethodsController < ApplicationController
  before_filter :access_user
  
  def edit
    @subscription = Subscription.cached_find(params[:id])
    @plan         = @subscription.plan
    build_cc_month
    build_cc_years
  end
  
  def update
    ap params
    @subscription       =  Subscription.cached_find(params[:id])
    
    ap ChangeSubscriptionCard.call(@subscription, params[:stripeToken])
    
    #if subscription.save
    #  StripeChargerSubscriptionJob.perform_later(subscription.guid)
    #  render json: { guid: subscription.guid }
    #else
    #  ap 'error +'
    #  errors = subscription.errors.full_messages
    #  render json: { error: errors.join(" ") }, status: 400
    #end
    
    
    
    redirect_to root_path
    #ChangeSubscriptionCard.call(@subscription, @subscription.stripe_token)
    #if plan = params[:plan_id] && Plan.where(id: params[:plan_id]).first
    #  msg = @subscription.change_plan(plan.id)
    #  if msg
    #    flash[:danger] = msg
    #  else
    #    flash[:info] = "Your will receive an email in a few minutes when your plan has changed" 
    #  end
    #else
    #  @subscription.cancel_when_plan_expires
    #end
    #
    #redirect_to user_user_control_panel_index_path(@user)
    
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
