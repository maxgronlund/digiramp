class LyricsController < ApplicationController
  #include AccountsHelper
  #before_action :access_account
  def edit
    #@common_work = CommonWork.cached_find(params[:common_work_id])
    @user = User.friendly.find(params[:user_id])
    @recording = Recording.cached_find(params[:id])
  end
  
  def update
    @recording            = Recording.cached_find(params[:id])
    @recording.lyrics     = params[:recording][:lyrics]
    @recording.vocal      = params[:recording][:vocal]
    @recording.explicit   = params[:recording][:explicit]
    @recording.save
    @user             = User.friendly.find(params[:user_id])
    #@authorized       = true
  end
  

end
