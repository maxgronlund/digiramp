class RecordingMetaDataController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  def edit
     @recording      = Recording.find(params[:id])
     @recording.extract_metadata
  end
  
  def update
     @recording      = Recording.find(params[:id])
     @recording.update_attributes(recording_params)
     @recording.common_work.update_completeness
     unless @recording.instrumental
       redirect_to edit_account_recording_lyric_path(@account, @recording)
     else
       redirect_to :back
     end
     #@recording.update_attribures(recording_params)
  end
  
  private
  
  def recording_params
    params.require(:recording).permit!
  end
end
