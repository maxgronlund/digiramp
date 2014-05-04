class SharedRecordingsController < ApplicationController
  before_filter :access_user
  
  def index
    if @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: params[:shared_catalog_id]).first
      @catalog      = Catalog.cached_find(params[:shared_catalog_id])
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
    @catalog      = Catalog.cached_find(params[:shared_catalog_id])
    @recording    = Recording.cached_find(params[:id])
    
    #@user, @catalog, @recording
  end
  
  def update
    
    @recording      = Recording.find(params[:id])
    @common_work    = @recording.common_work 

    params[:recording][:cache_version] = @recording.cache_version + 1

    if @genre_category = params[:recording][:genre_category]
      params[:recording].delete :genre_category
    end


    params[:recording][:cache_version] = @recording.cache_version + 1
    
    if @genre_category = params[:recording][:genre_category]
      params[:recording].delete :genre_category
    end

    @recording.update_attributes(recording_params)
      

    redirect_to user_shared_catalog_shared_recording_path(@user, params[:shared_catalog_id], @recording)
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
