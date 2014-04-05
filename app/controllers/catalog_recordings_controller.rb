class CatalogRecordingsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
     @catalog         = Catalog.cached_find(params[:catalog_id])
     @recordings      = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
      
     
  end
  
  def new
    @recording = Recording.cached_find(params[:recording])
    @catalog   = Catalog.cached_find(params[:catalog_id])
    CatalogItem.where(catalog_id: @catalog.id, 
                        catalog_itemable_id: @recording.id, 
                        catalog_itemable_type: @recording.class.name)
               .first_or_create(catalog_id: @catalog.id, 
                                catalog_itemable_id: @recording.id, 
                                catalog_itemable_type: @recording.class.name)
                 
    # use ajax here
    redirect_to :back
  end
  
  def show

  end
  
  def add_all
    @catalog   = Catalog.cached_find(params[:catalog_id])
    
    if @recordings  = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
      @recordings.each do |recording|
        CatalogItem.where(catalog_id: @catalog.id, 
                          catalog_itemable_id: recording.id, 
                          catalog_itemable_type: recording.class.name)
                    .first_or_create( catalog_id: @catalog.id, 
                                      catalog_itemable_id: recording.id, 
                                      catalog_itemable_type: recording.class.name)
      end
    end
    
    redirect_to :back
    
  end
  
  def destroy
    @recording = Recording.cached_find(params[:id])
    @catalog   = Catalog.cached_find(params[:catalog_id])
    
    catalog_item = CatalogItem.where(catalog_id: @catalog.id, catalog_itemable_id: @recording.id, catalog_itemable_type: @recording.class.name).first
    catalog_item.destroy
    redirect_to :back
  end
end
