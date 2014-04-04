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
    redirect_to account_catalog_path( @account, @catalog)
  end

  def edit
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
