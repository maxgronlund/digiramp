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
    ap params
    @recording    = Recording.cached_find(params[:recording_id])
    params.delete :recording_id
    
    @common_work  = CommonWork.cached_find(params[:id])
    unless params[:common_work].nil?
      @common_work.update!(common_work_params)
    end
    
    @common_work.ipis.each do |ipi|
      ipi.attach_to_user
    end
    redirect_to user_user_common_work_path(@user, @common_work)
  end
  
  def create
    ap params
  end

  def delete
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
