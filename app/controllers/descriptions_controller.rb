class DescriptionsController < ApplicationController
  #include AccountsHelper
  #before_action :access_account
  def edit
    #@common_work = CommonWork.cached_find(params[:common_work_id])
    @user         = User.friendly.find(params[:user_id])
    @recording    = Recording.cached_find(params[:id])
  end
  
  def update
    @user               = User.friendly.find(params[:user_id])
    @recording          = Recording.cached_find(params[:id])
    @recording.comment  = params[:recording][:comment]
    #@recording.title    = params[:recording][:title]
    @recording.save
    @authorized         = true
    

  end
  

end
