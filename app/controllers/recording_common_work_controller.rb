class RecordingCommonWorkController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def edit
    
    @recording      = Recording.find(params[:id])
    @common_works   = CommonWork.account_search(@recording.account, @recording.title)
  end
  
  def update
    @recording      = Recording.find(params[:id])
    logger.debug '---------------------------------------------------------'
    logger.debug params[:recording][:common_work_id]
    @recording.common_work_id = params[:recording][:common_work_id]
    @recording.save
    
    redirect_to edit_account_recording_meta_datum_path(@account,@recording)

    
  end
  
end

