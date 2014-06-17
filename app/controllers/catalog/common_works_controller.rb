class Catalog::CommonWorksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  include ActionView::Helpers::TextHelper
  
  before_filter :access_account
  before_filter :access_catalog

  
  def index
    forbidden unless current_catalog_user.read_common_work?
    @common_works  = CommonWork.catalog_search(@catalog, params[:query]).order('title asc').page(params[:page]).per(32)
  end

  def show
    forbidden unless current_catalog_user.read_common_work?
    @common_work = CommonWork.cached_find(params[:id])
  end

  def new
    #forbidden unless current_account_user.create_catalog
    #@catalog = Catalog.new
  end
  
  def create
    
    #@catalog = Catalog.create(catalog_params)
    #flash[:info] = { title: "SUCCESS: ", body: "Catalog created" }
    #redirect_to catalog_account_catalog_path( @account, @catalog)
  end

  def edit
    forbidden unless current_catalog_user.read_common_work?
    @common_work = CommonWork.cached_find(params[:id])
  end
  
  def update
    # get the artwork url
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      @common_work.update_completeness
      redirect_to catalog_account_catalog_common_work_path( @account, @catalog, @common_work)
    else
      render :edit
    end
  end
  
  def recordings
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @recordings = @common_work.recordings
    
  end

  
  def new_recordings
    @common_work = CommonWork.cached_find(params[:common_work_id])
  end
  
  
  # submitted from the cattalog and been true transloadedit
  # adding multiply recordings to an catalog by uploading files
  def create_recordings
    @common_work           = CommonWork.cached_find(params[:common_work_id])

    begin
      puts params[:recording][:add_to_catalogs]
      #params[:recording].delete :add_to_catalog
      
      if recordings = TransloaditRecordingsParser.parse( params[:transloadit], @account.id )
        recordings.each do |recording|
          recording.common_work_id = @common_work.id
          recording.save!
        end
        flash[:info]      = { title: "Success", body: "#{pluralize(recordings.size, "recorcing")} uploaded" }
      end
      
      # selection from drop down
      case params[:recording][:add_to_catalogs]
        
      when 'All Catalogs'
        @account.catalogs.each do |catalog|
          catalog.add_recordings recordings
        end
      when 'This Only'
        @catalog.add_recordings recordings
      end
    
      redirect_to catalog_account_catalog_common_work_path( @account, @catalog, @common_work )
    rescue
      flash[:danger]      = { title: "Unable to create Recording", body: "Please check if you selected a valid file" }
      #redirect_to catalog_account_catalog_common_work_new_recordings_path(@account, @catalog, @common_work )
      redirect_to :back
    end

  end
  
  def destroy
    #@catalog = Catalog.find(params[:id])
    #@catalog.destroy
    #redirect_to catalog_account_catalogs_path( @account)
  end
  
  #def find_in_collection
  #  
  #end
  
  def remove_common_work_from_catalog
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @remove_tag  = "#remove_from_catalog_"       + @common_work.id.to_s
    
    catalog_item = CatalogItem.where(
                      catalog_id: @catalog.id, 
                      catalog_itemable_id: @common_work.id, 
                      catalog_itemable_type: @common_work.class.name 
                    ).first
    
    remove_recordings catalog_item.catalog_itemable         
    
    catalog_item.destroy!
  end
  
  def remove_recordings common_work
    
    #if common_work.recordings
    common_work.recordings.each do |recording|
      catalog_item = CatalogItem.where(
                        catalog_id: @catalog.id, 
                        catalog_itemable_id: recording.id, 
                        catalog_itemable_type: recording.class.name 
                      ).first
      catalog_item.destroy! if catalog_item
    end
    #end
    
    
    
  end
  
  def add_common_work_from_collection

    @common_work = CommonWork.cached_find(params[:common_work_id])
    
    catalog_item = CatalogItem.where(
                                     catalog_id: @catalog.id, 
                                     catalog_itemable_id: @common_work.id, 
                                     catalog_itemable_type: 'CommonWork' 
                                   )
                              .first_or_create(
                                                  catalog_id: @catalog.id, 
                                                  catalog_itemable_id: @common_work.id, 
                                                  catalog_itemable_type: 'CommonWork' 
                                               )
                              

    @remove_tag  = "#add_to_catalog_#{@common_work.id.to_s}" 
    
    add_recordings( @catalog, catalog_item.catalog_itemable  )
    
  end
  
  # add recordings from common work to catalog
  def add_recordings catalog, common_work
    common_work.recordings.each do |recording|
      add_recording  catalog, recording
    end
    
  end
  
  # add one single recording
  def add_recording catalog, recording
    catalog_item = CatalogItem.where(
                                     catalog_id: catalog.id, 
                                     catalog_itemable_id: recording.id, 
                                     catalog_itemable_type: recording.class.name 
                                   )
                              .first_or_create(
                                                 catalog_id: catalog.id, 
                                                 catalog_itemable_id: recording.id, 
                                                 catalog_itemable_type: recording.class.name 
                                               )
  end
  
private

  def common_work_params
    params.require(:common_work).permit!
  end
  
  
end
