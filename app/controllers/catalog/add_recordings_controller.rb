class Catalog::AddRecordingsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [:show, :update, :edit]
  
  
  def index
     @catalog = Catalog.cached_find(params[:catalog_id])
  end
end
