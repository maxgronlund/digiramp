class AdminController < ApplicationController
  
  before_filter :admin_only
  def index
    @users = User.where(role: 'super')
    #where.('lower(email) ASC')
  end
  
  def flush_cache
    Rails.cache.clear
    admin = Admin.first
    admin.version += 1
    admin.save!
    Account.all.each do |account|
      account.rec_cache_version +=1
      account.save!
    end
    Recording.all.each do |recording|
      recording.cache_version +=1
      if recording.title.nil? || recording.title.empty?
        recording.destroy
      else
        recording.save!
      end
    end
    admin.flush_cache
    redirect_to :back
  end
end
