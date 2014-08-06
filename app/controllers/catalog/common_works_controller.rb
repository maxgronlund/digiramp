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
    ap params
    # get the artwork url
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes!(common_work_params)
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
  
  def create_common_work_ip
    forbidden unless current_catalog_user.create_common_work_ipi?
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    #@catalog  = Catalog.cached_find(params[:catalog_id])
    ip = Ipi.create(common_work_ipi_params)

    redirect_to catalog_account_catalog_common_work_common_work_ipis_path(@account, @catalog, @common_work)
    #Ipi.create()
    #redirect_to catalog_account_catalog_common_work_common_work_ipis_path( @account, @catalog, @common_work)
  end
  
  def update_common_work_ip
    forbidden unless current_catalog_user.update_common_work_ipi?
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    @catalog      = Catalog.cached_find(params[:catalog_id])
    @ipi          = Ipi.cached_find(params[:ipi][:id])
    
    @ipi.update_attributes(common_work_ipi_params)

    redirect_to catalog_account_catalog_common_work_common_work_ipis_path(@account, @catalog, @common_work)
    #Ipi.create()
    #redirect_to catalog_account_catalog_common_work_common_work_ipis_path( @account, @catalog, @common_work)
  end
  
  def edit_common_work_ipi_spread_sheet
    forbidden unless current_catalog_user.create_common_work_ipi?
    forbidden unless current_catalog_user.update_common_work_ipi?
    @common_work  = CommonWork.cached_find(params[:common_work_id])
  end
  
  def update_common_work_ipi_spread_sheet
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    ipi = @common_work.ipis.where(id: params[:ipi_id]).first
    ipi.update_attributes(common_work_ipi_params)
    redirect_to catalog_account_catalog_common_work_edit_common_work_ipi_spread_sheet_path(@account.id, @catalog.id, @common_work.id)
  end

  def common_work_ipi_params
    params.require(:ipi).permit!
  end
  
  
  # submitted from the cattalog and been true transloadedit
  # adding multiply recordings to an catalog by uploading files
  def create_recordings
    @common_work           = CommonWork.cached_find(params[:common_work_id])

    begin
      #puts params[:recording][:add_to_catalogs]
      #params[:recording].delete :add_to_catalog
      result = TransloaditRecordingsParser.parse( params[:transloadit], @account.id, false )
      
      nr_files_uploaded = 0
      if result[:recordings]
        result[:recordings].each do |recording|
          nr_files_uploaded += 1
          recording.common_work_id = @common_work.id
          recording.save!
        end
      end
      
      # success mesage
      flash[:info]      = { title: "Succes", body: "#{pluralize(nr_files_uploaded, "File")} uploaded" }
      
      # error messages
      unless result[:errors].size == 0
        errors     = ''
        nr_errors = 0
        result[:errors].each do |error|
          nr_errors += 1
          errors << error + '<br>'
        end
        flash[:danger]    = { title: "Errors", body: errors }
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
      puts '*********************************************'
      ap result
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
    #common_work.recordings.each do |recording|
    #  catalog_item = CatalogItem.where(
    #                    catalog_id: @catalog.id, 
    #                    catalog_itemable_id: recording.id, 
    #                    catalog_itemable_type: recording.class.name 
    #                  ).first
    #  catalog_item.destroy! if catalog_item
    #end
    #end
    
    
    
  end
  
  def remove
    catalog_items   = CatalogItem.where(
                      catalog_id: @catalog.id, 
                      catalog_itemable_type: 'CommonWork'
                    )
                    
    catalog_items.destroy_all if catalog_items   
        
    redirect_to catalog_account_catalog_common_works_path( @account, @catalog)
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
  
  #def export_common_works
  #  puts '>>>>>>>>>>>>>>>>>>>>>>>>> DOWNLOAD <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
  #  @common_works                             = CommonWork.catalog_search(@catalog, params[:query]).order('title asc').page(params[:page]).per(32)
  #  original_file_name                        = "#{@catalog.title}.csv"
  #  response.headers['Content-Type']          = 'text/plain'
  #  response.headers['Content-Disposition']   = "attachment; filename=#{original_file_name}"
  #  response.headers['Cache-Control']         =  "private"
  #  render text: @common_works.to_csv
  #  
  #  #render :nothing=>true
  #  #respond_to do |format|
  #  #  format.html
  #  #  #format.csv { render text: @common_works.to_csv }
  #  #  format.csv { render text: @common_works.to_csv }
  #  #end
  #end
  
  def export_common_works
    @common_works   = CommonWork.catalog_search(@catalog, params[:query]).order('title asc').page(params[:page]).per(32)
    #data            = @common_works.to_csv 
    respond_to do |format|
      format.html
      format.csv { 
        send_data(
          @common_works.to_csv, 
          disposition: "attachment; filename=#{@catalog.title}",
          type: 'text/csv',
          stream: 'true', 
          buffer_size: '4096' 
        )
      }
    end
  end
  
  def export_to_counterpoint
    @common_works  = CommonWork.catalog_search(@catalog, params[:query]).order('title asc')
    
    respond_to do |format|
      format.html
      #format.csv { render text: @common_works.to_csv }
      format.csv { render text: @common_works.to_counter_point }
    end
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end


#def download
#  if current_user
#    @recording                                = Recording.cached_find(params[:id])
#    original_file_name                        = Pathname.new(@recording.mp3).basename 
#    response.headers['Content-Type']          = 'audio/mp3'
#    response.headers['Content-Disposition']   = "attachment; filename=#{original_file_name}"
#    response.headers['Cache-Control']         =  "private"
#    #response.headers['X-Accel-Redirect']      = @recording.download_url
#  end
#  render :nothing=>true
#end
