class Catalog::AddCommonWorksController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
  
  
  def index
     #@catalog = Catalog.cached_find(params[:catalog_id])
  end
end
