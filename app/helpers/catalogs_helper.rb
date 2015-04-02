module CatalogsHelper

  def access_catalog
    begin
      if params[:catalog_id]
        @catalog = Catalog.cached_find(params[:catalog_id])
      elsif params[:id]
        @catalog = Catalog.cached_find(params[:id])
      end
      forbidden unless current_catalog_user
    rescue
      not_found
    end
    @user = current_user

    #forbidden unless current_catalog_user @catalog
  end
  
  def catalog_users
    current_user.super? ? 
                        @catalog.catalog_users.order("email asc") :  
                        @catalog.catalog_users.where( role: 'Catalog User').order("email asc")
    
  end

end
