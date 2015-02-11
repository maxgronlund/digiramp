class Catalog::AddRecordingsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
  
  
  def index
    #forbidden unless current_catalog_user.create_recording
    #@user = current_user
    #@authorized = true
    #@catalog = Catalog.cached_find(params[:catalog_id])
  end
  
  
  
  def add_found
    #ap '============================== ADD FOUND =================================='
    #ap params
    #ap session[:query] 
    
    
    @recordings     = Recording.not_in_bucket.find_in_collection(@catalog, @account, session[:query] )
    
    session[:query] = nil
    
    if @recordings
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
  
  def add_all
    #ap '============================ ADD ALL ===================================='
    #ap params
    if @recordings = @account.recordings.not_in_bucket
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
  
  
  
  
  
  
  
  
  
  
  
  
end
