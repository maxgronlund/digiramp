class SharedRecordingsController < ApplicationController
  before_filter :access_user
  
  def index
    
    if @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: params[:shared_catalog_id]).first
      @catalog       = Catalog.cached_find(params[:shared_catalog_id])
      
      recording_ids    = @catalog.catalog_items.where(catalog_itemable_type: "Recording").pluck(:catalog_itemable_id)
      @recordings      = Recording.where(id: recording_ids)
      @recordings      = Recording.catalogs_search(@recordings, params[:query]).order('title asc').page(params[:page]).per(48)
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end

  def show
    @catalog      = Catalog.cached_find(params[:shared_catalog_id])
    @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: @catalog.id).first
    @recording    = Recording.cached_find(params[:id])
  end
  
  def edit
    @catalog                = Catalog.cached_find(params[:shared_catalog_id])
    @recording              = Recording.cached_find(params[:id])
    @recording.genre        = @recording.genre_tags_as_csv_string
    @recording.instruments  = @recording.instruments_tags_as_csv_string
    @recording.mood         = @recording.moods_tags_as_csv_string
    
    #@user, @catalog, @recording
  end
  
  def update
    @recording      = Recording.cached_find(params[:id])
    @common_work    = @recording.common_work 
    
    params[:recording][:cache_version] = @recording.cache_version + 1


    if @genre_category = params[:recording][:genre_category]
      params[:recording].delete :genre_category
    end

    if @recording.update_attributes(recording_params)
      @recording.extract_genres
      @recording.extract_instruments
      @recording.extract_moods
      @recording.update_completeness
      
      
      #if @genre_category
      #  redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording,genre_category: @genre_category )
      #else
      #  redirect_to account_common_work_recording_path(@account, @common_work, @recording,genre_category: @genre_category )
      #end
    else
      
    end

    redirect_to user_shared_catalog_shared_recording_path(@user, params[:shared_catalog_id], @recording)
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
