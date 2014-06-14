module CatalogsHelper

  def access_catalog
    if params[:catalog_id]
      @catalog = Catalog.cached_find(params[:catalog_id])
    elsif params[:id]
      @catalog = Catalog.cached_find(params[:id])
    end
    forbidden unless current_catalog_user
    

    #forbidden unless current_catalog_user @catalog
  end

end
