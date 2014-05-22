class AdminController < ApplicationController
  
  before_filter :admin_only
  def index
    @users = User.where(role: 'super')
    #where.('lower(email) ASC')
  end
  
  def repair_permissions
    Account.all.each do |account|
      account.repair_users
      account.repair_recordings
      account.repair_works
      account.repair_catalogs
    end
    redirect_to :back
  end
  
  def flush_cache
    Rails.cache.clear
    admin = Admin.first
    admin.version += 1
    admin.save!
    Account.all.each do |account|
      account.save!
    end
    Recording.all.each do |recording|
      recording.save!
    end
    

    admin.flush_cache
    redirect_to :back
  end
end
