class Catalog::UploadRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  
  before_action :access_account
  before_action :access_catalog, only: [:index, :create]
  
  
  def index
    forbidden unless current_catalog_user.create_recording
    @catalog          = Catalog.cached_find(params[:catalog_id])
    @recording        = Recording.new
  end
  
  # when transloading is done
  def create
    forbidden unless current_catalog_user.create_recording

    
    result = TransloaditRecordingsParser.parse( params[:transloadit], @account.id, false, current_catalog_user.user_id )
    
    recordings = result[:recordings]
    
    # handle errors here
    
    # etach recording and assets to catalog
    recordings.each do |recording|
      # add recording
      add_recording_to_catalog recording
      # create and add common work
      create_and_add_common_work_to_catalog recording                   
      # add the artwork to the catalog
      add_artwork_to_catalog recording
      
      # add to the activity log
      recording.create_activity(  :created, 
                         owner: current_user,
                     recipient: recording,
                recipient_type: recording.class.name,
                    account_id: @account.id)
      
    end
    
    flash[:info]          = "Import completed" 
    
    @catalog.count_recordings
    @catalog.count_common_works
    @catalog.save!
    
    redirect_to catalog_account_catalog_recordings_path(@account, @catalog)
    #redirect_to account_import_batch_path(@account,   @import_batch)
  end
  
  # add to recording to catalog
  def add_recording_to_catalog recording
    
    @catalog.attach_recording recording

  end
  
  # create the common work and add it to the catalog
  def create_and_add_common_work_to_catalog recording
    # create common work                   
    common_work = CommonWork.attach( recording, @account.id, current_user )
                       
                       
    # activity log                    
    common_work.create_activity(  :created, 
                       owner: current_user,
                   recipient: common_work,
              recipient_type: common_work.class.name,
                  account_id: common_work.account_id)
    
    
    
    
    # add common work to catalog
    CatalogsCommonWorks.where(catalog_id: @catalog.id, common_work_id: common_work.id)
                       .first_or_create(catalog_id: @catalog.id, common_work_id: common_work.id)
            

    
  end
  
  # add artwork to catalogs 
  def add_artwork_to_catalog recording                  
    recording.artworks.each do |artwork|
      @catalog.add_artwork artwork
    end                      
  end
  
  
end
