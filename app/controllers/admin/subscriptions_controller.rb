class Admin::SubscriptionsController < ApplicationController
  before_action :admin_only
  
  def index
    @subscriptions = Subscription.order('created_at desc')
  end
  
  def show
    @subscription = Subscription.cached_find(params[:id])
    
  end
end
