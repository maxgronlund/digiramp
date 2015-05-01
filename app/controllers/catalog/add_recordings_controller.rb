class Catalog::AddRecordingsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_action :access_account
  before_action :access_catalog
  
  
  def index
    #forbidden unless current_catalog_user.create_recording
    #@user = current_user
    #@authorized = true
    #@catalog = Catalog.cached_find(params[:catalog_id])
  end
  
  
  
  def add_found

    @recordings     = Recording.not_in_bucket.find_in_collection(@catalog, @account, session[:query] )
    
    session[:query] = nil
    
    if @recordings
      @recordings.each do |recording|
        @catalog.attach_recording recording
      end
    end
    
    
  end
  
  def add_all

    if @recordings = @account.recordings.not_in_bucket
      @recordings.each do |recording|
         @catalog.attach_recording recording
      end
    end
  end

  
end
