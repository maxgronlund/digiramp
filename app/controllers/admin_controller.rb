class AdminController < ApplicationController
  
  #include ActionController::Live
  #
  #def stream
  #  response.headers['Content-Type'] = 'text/event-stream'
  #  10.times {
  #    response.stream.write "hello world\n"
  #    sleep 1
  #  }
  #ensure
  #  response.stream.close
  #end
  
  before_action :editor_only
  
  def index
    @users      = User.where(role: 'super')
    @user       = current_user
    #@authorized = true
    #where.('lower(email) ASC')
  end
  
  def repair_permissions
    RepairPermissionsWorker.perform_async()
    redirect_to :back
  end
  
  def flush_cache
    FlushCacheWorker.perform_async()
    redirect_to :back
  end
  
  def zapp_shop
    if Rails.env.development?
      
      RecordingDownload.destroy_all
      Stake.destroy_all
      Shop::OrderItem.destroy_all
      Shop::StripeTransfer.destroy_all
      Shop::Order.destroy_all
      Shop::Product.destroy_all
  
    end
    redirect_to :back
  end
end
