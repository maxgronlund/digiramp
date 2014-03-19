class AdminController < ApplicationController
  
  before_filter :admin_only
  def index
    @users = User.where(role: 'super')
    #where.('lower(email) ASC')
  end
  
  def flush_cache
    admin = Admin.first
    #logger.debug '--------------------------------------------------------------'
    admin.version += 1
    admin.save!
    #logger.debug admin.version
    #logger.debug '--------------------------------------------------------------'
    admin.flush_cache
    redirect_to :back
  end
end
