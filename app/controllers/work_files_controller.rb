class WorkFilesController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
    @common_work    = CommonWork.cached_find(params[:work_id])
  end
end
