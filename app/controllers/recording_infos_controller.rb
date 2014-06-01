class RecordingInfosController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account

  def show
    
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])

    
  end
end
