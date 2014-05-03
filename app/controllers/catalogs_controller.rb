class CatalogsController < ApplicationController
  
  before_filter :there_is_access_to_the_account
  
  def index
    @catalogs = @account.catalogs
  end

  def show
    @catalog = Catalog.cached_find(params[:id])
  end

  def new
    @catalog = Catalog.new
  end
  
  def create
    @catalog = Catalog.create(catalog_params)
    flash[:info] = { title: "SUCCESS: ", body: "Catalog created" }
    redirect_to account_catalog_path( @account, @catalog)
  end

  def edit
    @catalog = Catalog.cached_find(params[:id])
  end
  
  def update
    @catalog = Catalog.cached_find(params[:id])
    @catalog.update_attributes(catalog_params)
    flash[:info] = { title: "SUCCESS: ", body: "Catalog updated" }
    redirect_to account_catalog_path( @account, @catalog)
  end
  
  def move
    @catalog = Catalog.cached_find(params[:catalog_id])
  end
  
  #def receive
  #  @catalog = Catalog.cached_find(params[:catalog_id])
  #end
  
  
  def get_catalog
    @catalog = Catalog.new
  end
  
  def receive
    @catalog = Catalog.where(move_code: params[:move_code]).first
    
    #if @catalog
    #  
    #logger.debug '--------------------------------------------'
    #logger.debug @catalog.inspect
    redirect_to :back
  end
  
  
  def confirm
    @catalog = Catalog.cached_find(params[:catalog_id])
    @catalog.move_code = UUIDTools::UUID.timestamp_create().to_s
    @catalog.save!
    redirect_to account_catalog_move_path @account, @catalog
  end
  
  def get_code
    @catalog = Catalog.cached_find(params[:catalog_id])
    @catalog.move_code = UUIDTools::UUID.timestamp_create().to_s
    @catalog.save!
    redirect_to account_catalog_move_path @account, @catalog
  end
  
  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
    redirect_to account_catalogs_path( @account )
  end
  
private

  def catalog_params
    params.require(:catalog).permit!
  end
  
  
end
