class UserRecordingsController < ApplicationController
  before_filter :access_user
  def index
    # all catalogs where the user is graned permission
    catalog_ids       =  CatalogUser.where(user_id: @user.id).pluck(:catalog_id)
    
    # all recordings from catalogs shared with the user
    recording_ids     =  CatalogItem.where(catalog_id: catalog_ids, catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    
    # all recordings from the users account
    recording_ids     += @user.account.recordings
    
    # pull rcordings
    @recordings       =  Recording.where(id: recording_ids).page(params[:page])

    # find recordings
    @recordings     =  Recording.catalogs_search(@recordings, params[:query]).order('title asc').page(params[:page]).per(24)
    
    # trigger permissions
    @show_more        = true
    #@recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
  end
  
  
end
