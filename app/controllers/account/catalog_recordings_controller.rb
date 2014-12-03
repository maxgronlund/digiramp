class Account::CatalogRecordingsController < ApplicationController
  include RecordingsHelper
  include AccountsHelper
  before_filter :access_account
  before_filter :read_recording, only:[ :show, 
                                        :files, 
                                        :artwork,
                                        :new_artwork,
                                        :create_artwork,
                                        :download
                                      ]
  
  def index
    forbidden unless current_account_user.read_recording?
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @recordings     = Recording.not_in_bucket.catalogs_search(@catalog.recordings, params[:query]).order('title asc').page(params[:page]).per(48)
    @show_more      = true
  end
  
  def new

  end
end
