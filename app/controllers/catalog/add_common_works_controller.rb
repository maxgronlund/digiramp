class Catalog::AddCommonWorksController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_action :access_account
  before_action :access_catalog
  
  
  def index
     #@catalog = Catalog.cached_find(params[:catalog_id])
  end
end
