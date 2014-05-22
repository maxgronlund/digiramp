class RecordingInfosController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account

  def show
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])

    access = false
    
    if current_user.can_administrate @account
      access = true
    elsif @common_work.is_accessible_by current_user
      access = true
    end

    unless access
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
