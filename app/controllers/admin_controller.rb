class AdminController < ApplicationController
  
  include ActionController::Live

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    10.times {
      response.stream.write "hello world\n"
      sleep 1
    }
  ensure
    response.stream.close
  end
  
  before_filter :admin_only
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
end
