class AddCatalogAssetsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def show
     @catalog = Catalog.cached_find(params[:id])
  end
end
