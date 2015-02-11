class Catalog::FindInCollectionsController < ApplicationController
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_account
  before_filter :access_catalog, only: [:index, :show, :edit,  :create, :update]
  #before_filter :there_is_access_to_catalog
  
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
    ap params[:recording][:recording_id]
    ap params[:recording][:catalog_id]
    forbidden unless current_catalog_user.create_recording?
    if @recording = Recording.cached_find(params[:recording][:recording_id])
      if @catalog   = Catalog.cached_find(params[:recording][:catalog_id])
      
        CatalogItem.where(  catalog_id: @catalog.id, 
                            catalog_itemable_id: @recording.id, 
                            catalog_itemable_type: @recording.class.name)
                   .first_or_create(catalog_id: @catalog.id, 
                                    catalog_itemable_id: @recording.id, 
                                    catalog_itemable_type: @recording.class.name)
        
      end
    end
  end

  #def new
  #  ap params
  #  #@catalog   = Catalog.cached_find(params[:catalog_id])
  #  #@recording = Recording.cached_find(params[:recording])
  #  #
  #  #CatalogItem.where(catalog_id: @catalog.id, 
  #  #                    catalog_itemable_id: @recording.id, 
  #  #                    catalog_itemable_type: @recording.class.name)
  #  #           .first_or_create(catalog_id: @catalog.id, 
  #  #                            catalog_itemable_id: @recording.id, 
  #  #                            catalog_itemable_type: @recording.class.name)
  #  #             
  #  #
  #  ## ajax here
  #  ##@prepend_tag = "#remove_recording_" + @recording.id.to_s  + "_from_catalog"
  #  ##@remove_tag  = "#add_recording_"    + @recording.id.to_s  + "_to_catalog"
  #  #
  #  #@prepend_tag = "#remove_from_catalog_"  + @recording.id.to_s
  #  #@remove_tag  = "#add_to_catalog_"       + @recording.id.to_s
  #end
  
  
  
  
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
    if @recordings  = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
      @recordings.each do |recording|

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

        CatalogItem.where(catalog_id:                         @catalog.id, 
                          catalog_itemable_id:                recording.id, 
                          catalog_itemable_type:              recording.class.name)
                    .first_or_create( catalog_id:             @catalog.id, 
                                      catalog_itemable_id:    recording.id, 
                                      catalog_itemable_type:  recording.class.name)
      end
    end
    
    
  end
  
  
  def destroy
    @catalog   = Catalog.cached_find(params[:catalog_id])
    @recording = Recording.cached_find(params[:id])
    
    
    if catalog_item = CatalogItem.where( catalog_id: @catalog.id, 
                                      catalog_itemable_id: @recording.id, 
                                      catalog_itemable_type: @recording.class.name).first
                                      
      catalog_item.destroy!
    end
    
    
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
    
end
  