class Account::RecordingsBucketController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
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
      session[:recording_ids]
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
    #ap params
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
    @recording_ids = Recording.where(id: params[:recording_ids]).pluck(:id)
    #@recordings
    #@recording_ids = params[:recording_ids]
    #@recordings = Recording.find(session[:recording_ids])
  
  end
  
  def select_common_work
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
  end
  
  def use_common_work
    @common_work  = CommonWork.find(params[:common_work_id])
    @recordings   = Recording.find(session[:recording_ids])
    

    @recordings.each do |recording|
      recording.common_work_id = @common_work.id
      recording.in_bucket = false
      recording.save!
    end
    
    flash[:success] = { title: "Success", body: "Recordings added to common work" }
    redirect_to account_account_common_work_path(@account, @common_work)
    
  end
  
  
  def new_common_work
    @common_work    = CommonWork.new
    @recording_ids = Recording.where(id: params[:recording_ids]).pluck(:id)
  end
  
  def create_common_work
    forbidden unless current_account_user.create_common_work
    
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]
    puts '-------------------------------------------'
    puts artwork_url
    puts '-------------------------------------------'
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url
    
    @recording_ids    = eval(params[:common_work][:recording_ids])
    @recordings       = Recording.where(id: @recording_ids  )
    
    params[:common_work].delete :recording_ids
    if @common_work = CommonWork.create(common_work_params)
      
      @recordings.each do |recording|
        recording.common_work_id = @common_work.id
        recording.in_bucket = false
        recording.save!
      end
      @common_work.update_completeness
      redirect_to account_account_common_work_path(@account, @common_work)
    else
      redirect_to :back
    end
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
  
  def common_work_params
    params.require(:common_work).permit!
  end
end
