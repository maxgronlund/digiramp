class AdminController < ApplicationController
  
  before_filter :admin_only
  def index
    @users      = User.where(role: 'super')
    @user       = current_user
    @authorized = true
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
