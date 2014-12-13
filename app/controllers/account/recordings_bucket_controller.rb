class Account::RecordingsBucketController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_filter :access_account
  
  def index
    forbidden unless current_account_user.read_recording?
    @recordings     = Recording.bucket.account_bucket_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
    @user           = current_user
    @authorized     = true
  end
  
  def edit
    @recording = Recording.cached_find(542)
  end
  
  def show
    @recording = Recording.cached_find(params[:id])
  end
  
  def edit_multiple
    if params[:recording_ids].nil?
      flash[:danger] = { title: "Error", body: "You have to check at least one recording to edit" }
      redirect_to account_account_recordings_bucket_index_path(@account)
    else
      @recordings = Recording.find(params[:recording_ids])
    end
  end
  
  def update_multiple
    
    Recording.update(params[:recordings].keys, params[:recordings].values)
    redirect_to edit_shared_account_account_recordings_bucket_index_path(@account, ids: params[:recordings].keys )

  end
  
  def edit_shared
    @recordings = Recording.find(params[:ids] )
  end
  

  def update_shared

    @recordings = Recording.find(params[:recording_ids])

    @recordings.reject! do |recording|
      recording.update_attributes( recording_params.reject { |k,v| v.blank? })
      recording.extract_genres
      recording.extract_instruments
      recording.extract_moods
    end

    ids = params[:recording_ids].each { |x| x.to_s} #

    redirect_to add_to_common_work_account_account_recordings_bucket_index_path(@account, ids: ids)
    
  end
  
  def add_to_common_work
    @recording_ids = params[:ids].each { |x| x.to_s} #Recording.where(id: params[:recording_ids]).pluck(:id)
  end
  
  def select_common_work
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    @recording_ids = params[:ids].each { |x| x.to_s}
  end
  
  def use_common_work
    @common_work  = CommonWork.find(params[:common_work_id])
    @recordings   = Recording.find(params[:ids])
    

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
    @recording_ids  = params[:ids].each { |x| x.to_s} #Recording.where(id: params[:recording_ids]).pluck(:id)
  end
  
  def create_common_work
    forbidden unless current_account_user.create_common_work
    
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url
    
    @recording_ids    = eval(params[:common_work][:recording_ids])
    @recordings       = Recording.where(id: @recording_ids  )
    
    params[:common_work].delete :recording_ids
    if @common_work = CommonWork.create(common_work_params)
      @common_work.create_activity(  :created, 
                                owner: current_user,
                            recipient: @common_work,
                       recipient_type: @common_work.class.name,
                           account_id: @account.id)
                           
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
  
  
  
  def new_catalog
    # !!! update permissions 
    #forbidden unless current_account_user.createx_catalog?
    @catalog = Catalog.new
    @recording_ids  = params[:ids].each { |x| x.to_s} 
  end
  
  
  
  def create_catalog
    forbidden unless current_account_user.createx_catalog?

    recording_ids    = eval(params[:catalog][:ids])
    @recordings      = Recording.find( recording_ids )
    
    params[:catalog].delete :ids
    
    @catalog = Catalog.create(catalog_params)
    @recordings.each do |recording|
      
      common_work = CommonWork.create(
                                        account_id: recording.account_id,
                                        title:      recording.title,
                                        lyrics:     recording.lyrics,
                                        genre:      recording.genre
                                      )
                                      
      common_work.create_activity(  :created, 
                                owner: current_user,
                            recipient: common_work,
                       recipient_type: common_work.class.name,
                           account_id: @account.id)  
                                                         
      recording.common_work_id = common_work.id
      recording.in_bucket      = false
      recording.save!
      @catalog.add_recording recording
      common_work.update_completeness
    end
    #
    #redirect_to common_works_account_account_recordings_bucket_index_path(@account, common_work_ids: common_work_ids)
    redirect_to catalog_account_catalog_path( @account, @catalog)
  end
  
  def create_common_works

    common_work_ids = []
    @recordings       = Recording.where(id: params[:ids]  )
    @recordings.each do |recording|
      
      common_work = CommonWork.create(
                                        account_id: recording.account_id,
                                        title:      recording.title,
                                        lyrics:     recording.lyrics,
                                        genre:      recording.genre
                                        
                                      )
                                      
      common_work.create_activity(  :created, 
                                owner: current_user,
                            recipient: common_work,
                       recipient_type: common_work.class.name,
                           account_id: @account.id)
                           
                           
      recording.common_work_id = common_work.id
      recording.in_bucket      = false
      recording.save!
      common_work.update_completeness
      common_work_ids << common_work.id

    end
    
    redirect_to common_works_account_account_recordings_bucket_index_path(@account, common_work_ids: common_work_ids)
    
  end
  
  def common_works
    @common_works       = CommonWork.where(id: params[:common_work_ids]  )

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

  def catalog_params
    params.require(:catalog).permit!
  end
  
end
