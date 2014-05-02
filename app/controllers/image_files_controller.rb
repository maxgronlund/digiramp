# this is images files for recordings
class ImageFilesController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_filter :there_is_access_to_the_account
  
  before_action :set_image_file, only: [:show, :edit, :update, :destroy]

  # GET /image_files
  # GET /image_files.json
  def index
    
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
  end

  # GET /image_files/1
  # GET /image_files/1.json
  def show
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])

  end

  # GET /image_files/new
  def new
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.new
  end

  # GET /image_files/1/edit
  def edit
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
  end

  # POST /image_files
  # POST /image_files.json
  def create
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
    
    TransloaditImageParser.parse_images( params[:transloadit], @account.id, @recording.id )
    @transcoded     = params[:transloadit]
    #@import_batch.image_files.each do |image_file|
    #  
    #end
    
    #redirect_to account_common_work_recording_image_files_path(@account, @common_work, @recording)
    
    redirect_to  account_common_work_recording_artwork_path(@account, @common_work, @recording)
    
    
    
  end

  # PATCH/PUT /image_files/1
  # PATCH/PUT /image_files/1.json
  def update
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
    
    params[:image_file].delete :common_work_id
    
    if @image_file.update(image_file_params)

      redirect_to account_common_work_recording_image_file_path @account, @common_work, @recording, @image_file
    end
  end

  # DELETE /image_files/1
  # DELETE /image_files/1.json
  def destroy
    @image_file.destroy
    respond_to do |format|
      format.html { redirect_to image_files_url }
      format.json { head :no_content }
    end
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
