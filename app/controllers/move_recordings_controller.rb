class MoveRecordingsController < ApplicationController
  include RecordingsHelper
  include AccountsHelper
  before_filter :access_account
  #before_filter :read_recording, only:[:edit, :update]
  
  def edit
    @common_work            = CommonWork.cached_find(params[:common_work_id])
    @recording              = Recording.cached_find(params[:id])
    @recording.genre        = @recording.genre_tags_as_csv_string
    @recording.instruments  = @recording.instruments_tags_as_csv_string
    @recording.mood         = @recording.moods_tags_as_csv_string
    
    #@recording.copy_genre_tags_in_to_genre_string
    if params[:genre_category]
      redirect_to account_common_work_recording_genre_tags_path(@account, @common_work, @recording, genre_category: params[:genre_category])
    end
  end
  
  def update
    
  end
end
