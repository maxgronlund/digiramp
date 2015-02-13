class User::CommonWorkLyricsController < ApplicationController
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
    ap params
    @recording    = Recording.cached_find(params[:recording_id])
    @common_work  = CommonWork.cached_find(params[:id])
    
  end

  def update
    @recording    = Recording.cached_find(params[:recording_id])
    params.delete :recording_id
    @common_work  = CommonWork.cached_find(params[:id])
    @common_work.update(common_work_params)

    redirect_to edit_user_user_recording_common_work_credit_path(@user, @recording, @common_work)
    
  end

  def delete
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
