class Catalog::SelectArtworkFromController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_action :access_account
  before_action :access_catalog, only: [:index]
  
  
  def index
    forbidden unless current_catalog_user.create_artwork
     #@catalog = Catalog.cached_find(params[:catalog_id])
  end
  
end
