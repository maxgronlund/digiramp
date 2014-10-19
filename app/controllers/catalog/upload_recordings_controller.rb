class Catalog::UploadRecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [:index, :create]
  
  
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
    
    flash[:info]          = { title: "SUCCESS: ", body: "Import completed" }
    
    @catalog.count_recordings
    @catalog.count_common_works
    @catalog.save!
    
    redirect_to catalog_account_catalog_recordings_path(@account, @catalog)
    #redirect_to account_import_batch_path(@account,   @import_batch)
  end
  
  # add to recording to catalog
  def add_recording_to_catalog recording
    
    catalog_item = CatalogItem.create( catalog_id: @catalog.id,
                                       catalog_itemable_type: 'Recording',
                                       catalog_itemable_id: recording.id
                                      )
     # activity log                   
     catalog_item.create_activity(  :created, 
                        owner: current_user,
                    recipient: catalog_item,
               recipient_type: catalog_item.class.name,
                   account_id: @account.id)
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
    catalog_item = CatalogItem.create( catalog_id: @catalog.id,
                                       catalog_itemable_type: 'CommonWork',
                                       catalog_itemable_id: common_work.id
                                      )
                       
                       
    # activity log                   
    catalog_item.create_activity(  :created, 
                       owner: current_user,
                   recipient: catalog_item,
              recipient_type: catalog_item.class.name,
                  account_id: @account.id)
    
    
    
  end
  
  # add artwork to catalogs 
  def add_artwork_to_catalog recording
                           
    # get all artwork files, kind of optimistic hence ther is at max one artwork after upload                    
    recording.artworks.each do |artwork|
      CatalogItem.create( catalog_id:            @catalog.id,
                          catalog_itemable_type: 'Artwork',
                          catalog_itemable_id:    artwork.id
                         )
    end                      
  end
  
  
end
