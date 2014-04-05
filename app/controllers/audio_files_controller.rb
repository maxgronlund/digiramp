class AudioFilesController < ApplicationController
  before_filter :there_is_access_to_the_account
  include Transloadit::Rails::ParamsDecoder
  
  def edit
    @recording            = Recording.cached_find(params[:id])
    @common_work          = CommonWork.cached_find(params[:common_work_id])
  end
  
  def update
    flash[:info] = { title: "SUCCESS: ", body: "Audio file uploaded" }
    @recording              = Recording.cached_find(params[:id])
    @common_work            = CommonWork.cached_find(params[:common_work_id])
    transloadets            = TransloaditParser.update(@recording, params[:transloadit] )
    redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording )
  end

  
end
