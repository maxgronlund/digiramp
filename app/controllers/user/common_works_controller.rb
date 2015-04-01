class User::CommonWorksController < ApplicationController
  before_filter :access_user


  
  def index
    
  end

  def show
    #@recording    = Recording.cached_find(params[:recording_id])
    @common_work  = CommonWork.cached_find(params[:id])
  end

  #def new
  #end
  #
  #def create
  #  
  #end

  def edit
    #@recording    = Recording.cached_find(params[:recording_id])
    @common_work = CommonWork.cached_find(params[:id])
  end

  def update
    #@recording    = Recording.cached_find(params[:common_work][:recording_id])
    #params[:common_work].delete :recording_id
    @common_work  = CommonWork.cached_find(params[:id])
    @common_work.update(common_work_params)
    
    #redirect_to edit_user_user_recording_common_work_lyric_path(@user, @recording, @common_work)
    redirect_to edit_user_user_common_work_lyric_path(@user, @common_work)
    
  end

  def delete
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
