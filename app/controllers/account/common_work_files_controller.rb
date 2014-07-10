class Account::CommonWorkFilesController < ApplicationController
  
  include AccountsHelper
  before_filter :access_account
  
  
  def index
    @common_work = CommonWork.cached_find(params[:common_work_id])
  end

end
