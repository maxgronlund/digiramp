class LyricsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def edit
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @recording = Recording.cached_find(params[:id])
  end
  
  def update
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @recording = Recording.cached_find(params[:id])
    @recording.lyrics = params[:recording][:lyrics]
    @recording.save
    @recording.common_work.update_completeness
    redirect_to account_common_work_recording_path @account, @common_work, @recording
  end
  

end
