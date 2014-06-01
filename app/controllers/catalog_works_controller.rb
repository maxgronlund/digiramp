class CatalogWorksController < ApplicationController
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_to_account
  before_filter :access_catalog, only: [:index, :show, :edit, :update]
  
  def index
    forbidden unless current_catalog_user.read_common_work
    @common_works = @catalog.common_works 
  end
  
  def show
    forbidden unless current_catalog_user.read_common_work
    @common_work = CommonWork.cached_find(params[:id])
  end
end
