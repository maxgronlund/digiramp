class Catalog::AddRecordingsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
  
  
  def index
    forbidden unless current_catalog_user.create_recording
    @user = current_user
    @authorized = true
    #@catalog = Catalog.cached_find(params[:catalog_id])
  end
end
