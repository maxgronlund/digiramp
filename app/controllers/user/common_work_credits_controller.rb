class User::CommonWorkCreditsController < ApplicationController
  before_filter :access_user
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
    
    @recording    = Recording.cached_find(params[:recording_id])
    @common_work = CommonWork.cached_find(params[:id])
    
  end

  def update

    @recording    = Recording.cached_find(params[:recording_id])
    params.delete :recording_id
    
    @common_work  = CommonWork.cached_find(params[:id])
    unless params[:common_work].nil?
      @common_work.update(common_work_params)
    end
    
    redirect_to user_user_recording_common_work_path(@user, @recording, @common_work)
    
  end

  def delete
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
