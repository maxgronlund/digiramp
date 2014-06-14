# this is images files for recordings
class Catalog::ImageFilesController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_account
  before_filter :access_catalog, only: [:index, :show, :update, :edit, :new, :create, :destroy]
  
  before_action :set_image_file, only: [:show, :edit, :update, :destroy]

  # GET /image_files
  # GET /image_files.json
  def index

    @recording      = Recording.cached_find(params[:recording_id])
  end

  # GET /image_files/1
  # GET /image_files/1.json
  def show
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
  end

  # GET /image_files/new
  def new
    
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.new
  end

  # GET /image_files/1/edit
  def edit
    
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
  end

  # POST /image_files
  # POST /image_files.json
  def create
    #begin

      @recording      = Recording.cached_find(params[:recording_id])
      
      TransloaditImageParser.parse_images( params[:transloadit], @account.id, @recording.id )
      @transcoded     = params[:transloadit]
      #@import_batch.image_files.each do |image_file|
      #  
      #end
      
      #redirect_to account_common_work_recording_image_files_path(@account, @common_work, @recording)
      redirect_to  catalog_account_catalog_recording_image_files_path(@account, @catalog, @recording)
      #rescue
      #flash[:danger] = { title: "Sorry: ", body: "Something went wrong" }
      #redirect_to :back
      #end
    
    
    
    
  end

  # PATCH/PUT /image_files/1
  # PATCH/PUT /image_files/1.json
  def update
   
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])

    #params[:image_file].delete :keywords
    params[:image_file].delete :catalog_id
    
    if @image_file.update(image_file_params)

      redirect_to catalog_account_catalog_recording_image_file_path @account, @catalog, @recording, @image_file
    end
  end

  # DELETE /image_files/1
  # DELETE /image_files/1.json
  def destroy

    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
    
    # check if recoring uses the artwork
    @image_file.destroy! unless @image_file.id == @recording.image_file_id
    
    redirect_to catalog_account_catalog_recording_image_files_path @account, @catalog, @recording
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_file
      @image_file = ImageFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_file_params
      params.require(:image_file).permit!
    end
end
