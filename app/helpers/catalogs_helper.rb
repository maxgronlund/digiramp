module CatalogsHelper
  

  
  def current_catalog_user 
    @catalog.catalog_users.where(user_id: current_user.id, catalog_id: @catalog.id).first
  end
  
  def access_catalog
    if params[:catalog_id]
      @catalog = Catalog.cached_find(params[:catalog_id])
    elsif params[:id]
      @catalog = Catalog.cached_find(params[:id])
    end
    forbidden unless current_catalog_user
  end
  
end
