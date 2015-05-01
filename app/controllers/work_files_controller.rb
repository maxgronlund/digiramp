class WorkFilesController < ApplicationController
  include AccountsHelper
  before_action :access_account

  def index
    forbidden unless current_account_user.read_file
    @common_work    = CommonWork.cached_find(params[:work_id])
    
  end

end
