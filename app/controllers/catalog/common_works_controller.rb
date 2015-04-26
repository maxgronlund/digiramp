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
    @common_work.create_activity(  :show, 
                       owner: current_user,
                   recipient: @common_work,
              recipient_type: @common_work.class.name,
                  account_id: @common_work.account_id)
                  
    
  end

  def new

  end
  
  def create
    

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
    if @common_work.update_attributes!(common_work_params)
      
      @common_work.create_activity(  :updated, 
                                owner: current_user,
                            recipient: @common_work,
                       recipient_type: @common_work.class.name,
                           account_id: @account.id)
                           
                           
      @common_work.update_completeness
      redirect_to catalog_account_catalog_common_work_path( @account, @catalog, @common_work)
    else
      render :edit
    end
  end
  
  def recordings
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @recordings = @common_work.recordings
    
    @common_work.create_activity(  :show, 
                       owner: current_user,
                   recipient: @common_work,
              recipient_type: @common_work.class.name,
                  account_id: @common_work.account_id)
    
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


      #puts params[:recording][:add_to_catalogs]
      #params[:recording].delete :add_to_catalog
      result = TransloaditRecordingsParser.parse( params[:transloadit], @account.id, false, current_catalog_user.user_id )
      
      nr_files_uploaded = 0
      if result[:recordings]
        result[:recordings].each do |recording|
          nr_files_uploaded += 1
          recording.common_work_id = @common_work.id
          recording.save!
        end
      end

      
      # selection from drop down
      if params[:recording][:add_to_catalogs] == 'All Catalogs'
        @account.catalogs.each do |catalog|
          catalog.attach_recordings result[:recordings]
        end
      else 

        @catalog.attach_recordings result[:recordings]
      end

      redirect_to catalog_account_catalog_common_work_path( @account, @catalog, @common_work )




  end
  
  def destroy

  end

  def remove_common_work_from_catalog
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @remove_tag  = "#remove_from_catalog_"       + @common_work.id.to_s
    
    @common_work.recordings.each do |recording|
      if catalog_recording = CatalogsRecordings.where(recording_id: recording.id, catalog_id: @catalog.id).first
        catalog_recording.destroy!
      end
      
    end
    
    if catalog_common_work = CatalogsCommonWorks.where(catalog_id: @catalog.id, common_work_id: @common_work.id).first
      
      
      catalog_common_work.destroy!
    end
    
  end

  def remove_recordings common_work
    
    
  end
  
  def remove
    
    if catalog_common_works = CatalogsCommonWorks.where(catalog_id: @catalog.id, common_work_id: @common_work.id)
      catalog_common_works.destroy_all
    end
      
        
    redirect_to catalog_account_catalog_common_works_path( @account, @catalog)
  end
  
  def add_common_work_from_collection

    @common_work = CommonWork.cached_find(params[:common_work_id])
    
    @catalog.add_common_work @common_work
    @remove_tag  = "#add_to_catalog_#{@common_work.id.to_s}" 
    

    
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
      #format.csv { render text: @common_works.to_csv }
      format.csv { 
        send_data(
          @common_works.to_csv,  
          disposition: "attachment; filename=#{@catalog.title.gsub(' ', '-')}-#{ DateTime.now.to_date}.csv",
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
