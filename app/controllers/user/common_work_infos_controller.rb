class User::CommonWorkInfosController < ApplicationController
  before_action :access_user
  def show
    @common_work = CommonWork.cached_find(params[:id])
  end
end
