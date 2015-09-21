class User::CommonWorkWithoutRecordingsController < ApplicationController
  before_action :access_user
  def index
  end

  def show
    
    @common_work = CommonWork.cached_find(params[:id])
  end
end
