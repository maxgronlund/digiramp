class ArtistsController < ApplicationController

  def edit
    @user                 = User.friendly.find(params[:user_id])
    @recording            = Recording.cached_find(params[:id])
  end
  
  def update
    @recording            = Recording.cached_find(params[:id])
    @recording.performer  = params[:recording][:performer]
    @recording.artist     = params[:recording][:artist]
    @recording.composer   = params[:recording][:composer]
    @recording.band       = params[:recording][:band]
    @recording.save
    @user             = User.friendly.find(params[:user_id])
    @authorized       = true
    #@common_work = CommonWork.cached_find(params[:common_work_id])
    #@recording = Recording.cached_find(params[:id])
    #@recording.lyrics = params[:recording][:lyrics]
    #@recording.save
    #@recording.common_work.update_completeness
    #redirect_to account_common_work_recording_path @account, @common_work, @recording
  end
  

end
