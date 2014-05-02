class UserRecordingsController < ApplicationController
  before_filter :access_user
  def index
    catalog_ids      = CatalogUser.where(user_id: @user.id).pluck(:catalog_id)
    recording_ids    = CatalogItem.where(catalog_id: catalog_ids, catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    @recordings      = Recording.where(id: recording_ids).page(params[:page]).per(24)
    @recordings      = Recording.catalogs_search(@recordings, params[:query]).order('title asc').page(params[:page]).per(24)
    
    #@recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end
  
  
end
