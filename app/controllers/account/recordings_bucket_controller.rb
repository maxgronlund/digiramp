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
    

    recording_ids = []
    if params[:recording_ids].nil?
      
      flash[:danger] = { title: "Error", body: "You have to check at least one recording to edit" }
      redirect_to account_account_recordings_bucket_index_path(@account)
    else
      params[:recording_ids].each do |recording|
        recording_ids <<  recording
      end
      session[:recording_ids]  = recording_ids
      @recordings = Recording.find(params[:recording_ids])
      ap session[:recording_ids]
     end
  end
  
  def update_multiple
    Recording.update(params[:recordings].keys, params[:recordings].values)
    
    # build a nice little parameter block
    recordings = {}
    params[:recordings].each do |rec|
       recordings[rec[0].to_s ] = nil
    end
    params =  ActionController::Parameters.new( { "recordings" => recordings})
    
    
    redirect_to edit_shared_account_account_recordings_bucket_index_path(@account, params)

  end
  
  def edit_shared
    @recordings = Recording.find(params[:recordings].keys )
  end
  

  def update_shared
    @recordings = Recording.find(params[:recording_ids])

    @recordings.reject! do |recording|
      recording.update_attributes( recording_params.reject { |k,v| v.blank? })
    end
    
    #build a nice little parameter block
    recordings = []
    params[:recording_ids].each do |rec|
       recordings << rec
    end
    params =  ActionController::Parameters.new( { "recording_ids"=>recordings })
    
    redirect_to add_to_common_work_account_account_recordings_bucket_index_path(@account, params)
    
  end
  
  def add_to_common_work
    
    #@recordings = Recording.find(session[:recording_ids])
  
  end
  
  def new_common_work
    #@common_work    = CommonWork.find(params[:id])
  end
  
  def create_common_work
    
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
