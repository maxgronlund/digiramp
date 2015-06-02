# this is images files for recordings
class ImageFilesController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_action :access_account
  
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
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
    puts 'ERROR: ImageFiles is discontinued' 
    puts 'and do no longer work: use Artworks instead'
    puts 'In ImageFilesController#create'
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
    #begin
      #@common_work    = CommonWork.cached_find(params[:common_work_id])
      #@recording      = Recording.cached_find(params[:recording_id])
      #
      #TransloaditImageParser.parse_images( params[:transloadit], @account.id, @recording.id )
      #@transcoded     = params[:transloadit]
      ##@import_batch.image_files.each do |image_file|
      ##  
      ##end
      #
      ##redirect_to account_common_work_recording_image_files_path(@account, @common_work, @recording)
      #redirect_to  account_common_work_recording_artwork_path(@account, @common_work, @recording)
      ##rescue

      ##redirect_to :back
      ##end
    
    
    
    
  end

  # PATCH/PUT /image_files/1
  # PATCH/PUT /image_files/1.json
  def update
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
    

    
    params[:image_file].delete :keywords
    params[:image_file].delete :common_work_id
    
    if @image_file.update(image_file_params)

      redirect_to account_common_work_recording_image_file_path @account, @common_work, @recording, @image_file
    end
  end

  # DELETE /image_files/1
  # DELETE /image_files/1.json
  def destroy
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:recording_id])
    @image_file     = ImageFile.find(params[:id])
    
    # check if recoring uses the artwork
    @image_file.destroy! unless @image_file.id == @recording.image_file_id
    
    redirect_to account_common_work_recording_artwork_path(@account, @common_work, @recording)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_file
      @image_file = ImageFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_file_params
      params.require(:image_file).permit( :title,                 
                                          :body,
                                          :account_id,
                                          :file,       
                                          :recording_id,
                                          :thumb,                 
                                          :image_id,              
                                          :basename,              
                                          :ext,                   
                                          :image_size,            
                                          :mime,                  
                                          :image_type,            
                                          :md5hash,               
                                          :width,                 
                                          :height,                
                                          :date_recorded,         
                                          :date_file_created,     
                                          :date_file_modified,    
                                          :description,           
                                          :location,              
                                          :aspect_ratio,          
                                          :city,                  
                                          :state,                 
                                          :country,               
                                          :country_code,          
                                          :keywords,
                                          :aperture,              
                                          :exposure_compensation, 
                                          :exposure_mode,         
                                          :exposure_time,         
                                          :flash,                 
                                          :focal_length,          
                                          :f_number,              
                                          :iso,                   
                                          :light_value,           
                                          :metering_mode,         
                                          :shutter_speed,         
                                          :white_balance,         
                                          :device_name,           
                                          :device_vendor,         
                                          :device_software,       
                                          :latitude,              
                                          :longitude,             
                                          :orientation,           
                                          :has_clipping_path,     
                                          :creator,               
                                          :author,                
                                          :copyright,             
                                          :frame_count,           
                                          :copyright_notice
                                          )
    end
end
