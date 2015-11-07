class User::CommonWorkLyricsController < ApplicationController
  before_action :access_user
  #include AccountsHelper

  
  def index
    
  end

  def show
  end

  #def new
  #end
  #
  #def create
  #  
  #end

  def edit
    #@recording    = Recording.cached_find(params[:recording_id])
    @common_work  = CommonWork.cached_find(params[:id])
    @common_work_user = CommonWorkUser.find_by(user_id: @user.id, common_work_id: @common_work.id)
    forbidden unless (@common_work_user && @common_work_user.can_manage_common_work)
  end

  def update
    
    @common_work  = CommonWork.cached_find(params[:id])
    @common_work.update(common_work_params)

    redirect_to user_user_common_work_path( @user, @common_work)
    
  end

  def delete
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
