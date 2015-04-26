class Admin::SubscriptionsController < ApplicationController
  before_filter :admin_only
  
  def index
    @subscriptions = Subscription.order('created_at desc')
  end
  
  def show
    @subscription = Subscription.cached_find(params[:id])
    
  end
end
