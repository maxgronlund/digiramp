module SharedCatalogsHelper
  
  # read recording permissions
  def read_catalog
    if @catalog_user  = CatalogUser.where(user_id: @user.id, catalog_id: params[:shared_catalog_id]).first
      @catalog        = Catalog.cached_find(params[:shared_catalog_id])
      
      recording_ids   = @catalog.catalog_items.where(catalog_itemable_type: "Recording").pluck(:catalog_itemable_id)
      @recordings     = Recording.where(id: recording_ids)
      @recordings     = Recording.catalogs_search(@recordings, params[:query]).order('title asc').page(params[:page]).per(48)
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
  
  
end
