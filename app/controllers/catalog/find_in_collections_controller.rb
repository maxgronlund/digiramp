class Catalog::FindInCollectionsController < ApplicationController
  include AccountsHelper
  include CatalogsHelper
  before_action :access_account
  before_action :access_catalog, only: [:index, :show, :edit,  :create, :update]
  #before_action :there_is_access_to_catalog
  
  # list of recordings to add to the catalog
  def index
    forbidden unless current_account_user.read_recording?
    @recordings     = Recording.not_in_bucket.find_in_collection(@catalog, @account, params[:query]).order('title asc').page(params[:page]).per(48)
    #@recordings     = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
    #@recordings     -= @catalog.recordings
    @show_more      = true
    session[:query] = params[:query]
    #@user           = current_user
    #@authorized     = true
  end
  
  def create


    
    forbidden unless current_catalog_user.create_recording?
    if @recording = Recording.cached_find(params[:recording][:recording_id])
      if @catalog   = Catalog.cached_find(params[:recording][:catalog_id])
        
        CatalogsRecordings.where(catalog_id: @catalog.id, recording_id: @recording.id)
                          .first_or_create(catalog_id: @catalog.id, recording_id: @recording.id)

      end
    end
  end

 
  
  
  
  
  def show
    forbidden unless current_catalog_user.read_recording
    @recording = Recording.cached_find(params[:id])

  end
  
  def edit
    forbidden unless current_catalog_user.update_recording
    @recording = Recording.cached_find(params[:id])
  end
  
  def update
    forbidden unless current_catalog_user.update_recording
    @recording = Recording.cached_find(params[:id])
    params[:recording][:uuid] = UUIDTools::UUID.timestamp_create().to_s
    if @recording.update_attributes(recording_params)
      @recording.extract_genres
      @recording.extract_instruments
      @recording.extract_moods

      #if image_file = ImageFile.where(id: @recording.image_file_id).first
      #  @recording.cover_art = image_file.thumb
      #  @recording.save
      #end
      
      @recording.get_common_work.update_completeness
      
      #if @genre_category
      #  redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording, genre_category: @genre_category )
      #else
      #  redirect_to account_common_work_recording_path(@account, @common_work, @recording, genre_category: @genre_category )
      #end
      @catalog   = Catalog.cached_find(params[:catalog_id])
      redirect_to account_catalog_catalog_recording_info_path(@account, @catalog, @recording)
    else
      redirect_to :back
    end
    
  end
  
  def add_all
    # find catalog
    @catalog        = Catalog.cached_find(params[:catalog_id])
    # add recordings not in the catalog
    if @recordings  = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
      @recordings.each do |recording|
        CatalogsRecordings.where(catalog_id: @catalog.id, recording_id: recording.id)
                          .first_or_create(catalog_id: @catalog.id, recording_id: recording.id)
       
      end
    end
    
    redirect_to :back
  end
  
  def add_all_from_account
    # find catalog
    @catalog        = Catalog.cached_find(params[:catalog_id])
    # add recordings not in the catalog
    if @recordings  = @account.recordings
      @recordings.each do |recording|
        CatalogsRecordings.where(catalog_id: @catalog.id, recording_id: recording.id)
                          .first_or_create(catalog_id: @catalog.id, recording_id: recording.id)
                          
       
      end
    end
    
    
  end
  
  
  def destroy
    @catalog   = Catalog.cached_find(params[:catalog_id])
    @recording = Recording.cached_find(params[:id])
    
    if catalog_recording = CatalogsRecordings.where(catalog_id: @catalog.id, recording_id: @recording.id).first
      catalog_recording.destroy!
    end
   
  end
  
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
    
end
  