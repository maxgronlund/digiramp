class WorkRecordingsController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  def index
    @common_work    = CommonWork.cached_find(params[:work_id])
  end
end
