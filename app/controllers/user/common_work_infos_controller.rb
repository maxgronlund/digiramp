class User::CommonWorkInfosController < ApplicationController
  before_action :access_user
  def show
    @common_work = CommonWork.cached_find(params[:id])
    @common_work_user = CommonWorkUser.find_by(user_id: @user.id, common_work_id: @common_work.id )
  end
end
