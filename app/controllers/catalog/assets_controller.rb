class Catalog::AssetsController < ApplicationController
  #include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [:index, :new]
  
  
  def index
    forbidden unless current_catalog_user.access_assets?
     #@catalog = Catalog.cached_find(params[:catalog_id])
  end
  
  def new
    @attachable       = @catalog
    @attachment       = Attachment.new()
    @back             = catalog_account_catalogs_path( @account, @catalog)
  end
  
  def create
    
    
    
    
  end
end
