class Account::RecordingsBucketController < ApplicationController
  
  include AccountsHelper
  before_filter :access_account
  
  def index
    forbidden unless current_account_user.read_recording?
    @recordings     = Recording.bucket.account_bucket_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
  end
  
  def edit
    @recording = Recording.cached_find(542)
  end
  
  def show
    @recording = Recording.cached_find(params[:id])
  end
  
  def edit_multiple
    @recordings = Recording.find(params[:recording_ids])
  end
  
  def update_multiple
    Recording.update(params[:recordings].keys, params[:recordings].values)
    redirect_to edit_shared_account_account_recordings_bucket_index_path(@account, params)
    #account_account_recordings_bucket_index_path(@account)
  end
  
  def edit_shared
    @recordings = Recording.find(params[:recordings].keys )
    ap @recordings
  end
  

  def update_shared
    @recordings = Recording.find(params[:recording_ids])
    
    @recordings.reject! do |recording|
      recording.update_attributes( recording_params.reject { |k,v| v.blank? })
    end
    
    redirect_to account_account_recordings_bucket_index_path(@account)
  end
  
  def destroy
    @recording = Recording.cached_find(params[:id])
    @recording.destroy!
    
    redirect_to account_account_recordings_bucket_index_path(@account)
  end
  
  private
  
  def recording_params
    params.require(:recording).permit!
  end
end
