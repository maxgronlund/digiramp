class WorkIpisController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def index
    @common_work    = CommonWork.cached_find(params[:work_id])
    #if @common_work.ipis_is_accessible_by current_user
    #  render :index
    #else
    #  @common_work = nil
    #  render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    #end
  end
end
