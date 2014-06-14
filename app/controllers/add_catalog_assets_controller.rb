class AddCatalogAssetsController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  def show
     @catalog = Catalog.cached_find(params[:id])
  end
end
