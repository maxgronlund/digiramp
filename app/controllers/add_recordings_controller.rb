class AddRecordingsController < ApplicationController
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_to_account
  before_filter :access_catalog, only: [:index, :show, :edit, :update]
  #before_filter :there_is_access_to_catalog
  
  # list of recordings to add to the catalog
  def index
    # find catalog
    #@catalog         = Catalog.cached_find(params[:catalog_id])
    
    
    
    # all recordings currently in the catalog
    recording_in_catalog_ids   = @catalog.catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    #logger.debug recording_in_catalog_ids
    # all recordings
    recordings_ids             = @account.recordings.pluck(:id)
    #logger.debug recordings_ids
    #  recordings not in the catalog
    recordings_not_in_the_catalog_ids = recordings_ids - recording_in_catalog_ids
    #logger.debug recordings_not_in_the_catalog_ids
    # get them from the db
    recordings = Recording.where(id: recordings_not_in_the_catalog_ids)
    #logger.debug @recordings.size
    
    
    # do the search
    @recordings      = Recording.catalogs_search( recordings , params[:query]).order('title asc').page(params[:page]).per(24)
  end
  
  #def index
  #  # find catalog
  #  #@catalog         = Catalog.cached_find(params[:catalog_id])
  #  
  #  
  #  
  #  # all recordings currently in the catalog
  #  recording_in_catalog_ids   = @catalog.catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
  #  logger.debug recording_in_catalog_ids
  #  # all recordings
  #  recordings_ids             = @account.recordings.pluck(:id)
  #  logger.debug recordings_ids
  #  #  recordings not in the catalog
  #  recordings_not_in_the_catalog_ids = recordings_ids - recording_in_catalog_ids
  #  logger.debug recordings_not_in_the_catalog_ids
  #  # get them from the db
  #  @recordings = Recording.where(id: recordings_not_in_the_catalog_ids)
  #  logger.debug @recordings.size
  #  
  #  # do the search
  #  @recordings      = Recording.catalogs_search(@recordings, params[:query]).order('title asc').page(params[:page]).per(24)
  #end
  
  
  
  
  def new
    @catalog   = Catalog.cached_find(params[:catalog_id])
    @recording = Recording.cached_find(params[:recording])
    
    CatalogItem.where(catalog_id: @catalog.id, 
                        catalog_itemable_id: @recording.id, 
                        catalog_itemable_type: @recording.class.name)
               .first_or_create(catalog_id: @catalog.id, 
                                catalog_itemable_id: @recording.id, 
                                catalog_itemable_type: @recording.class.name)
                 

    # ajax here
    #@prepend_tag = "#remove_recording_" + @recording.id.to_s  + "_from_catalog"
    #@remove_tag  = "#add_recording_"    + @recording.id.to_s  + "_to_catalog"
    
    @prepend_tag = "#remove_from_catalog_"  + @recording.id.to_s
    @remove_tag  = "#add_to_catalog_"       + @recording.id.to_s
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

      if image_file = ImageFile.where(id: @recording.image_file_id).first
        @recording.cover_art = image_file.thumb
        @recording.save
      end
      
      @recording.common_work.update_completeness
      
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
    if @recordings  = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
      @recordings.each do |recording|
        logger.debug '.'
        CatalogItem.where(catalog_id:                         @catalog.id, 
                          catalog_itemable_id:                recording.id, 
                          catalog_itemable_type:              recording.class.name)
                    .first_or_create( catalog_id:             @catalog.id, 
                                      catalog_itemable_id:    recording.id, 
                                      catalog_itemable_type:  recording.class.name)
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
        logger.debug '.'
        CatalogItem.where(catalog_id:                         @catalog.id, 
                          catalog_itemable_id:                recording.id, 
                          catalog_itemable_type:              recording.class.name)
                    .first_or_create( catalog_id:             @catalog.id, 
                                      catalog_itemable_id:    recording.id, 
                                      catalog_itemable_type:  recording.class.name)
      end
    end
    
    redirect_to :back
  end
  
  # ajax here
  def destroy
    @catalog   = Catalog.cached_find(params[:catalog_id])
    @recording = Recording.cached_find(params[:id])
    
    
    catalog_item = CatalogItem.where( catalog_id: @catalog.id, 
                                      catalog_itemable_id: @recording.id, 
                                      catalog_itemable_type: @recording.class.name).first
                                      
    catalog_item.destroy! if catalog_item
    
    @prepend_tag = "#add_to_catalog_"         + @recording.id.to_s
    @remove_tag  = "#remove_from_catalog_"    + @recording.id.to_s
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
    
end
  