class Admin::RawImagesController < ApplicationController
  before_action :set_raw_image, only: [:show, :edit, :update, :destroy]
  before_filter :admins_only
  # GET /raw_images
  # GET /raw_images.json
  def index
    @raw_images = RawImage.all
    #@user = current_user
    #@authorized = true
  end

  # GET /raw_images/1
  # GET /raw_images/1.json
  def show
  end

  # GET /raw_images/new
  def new
    @raw_image = RawImage.new
  end

  # GET /raw_images/1/edit
  def edit
  end

  # POST /raw_images
  # POST /raw_images.json
  def create
    @raw_image = RawImage.new(raw_image_params)
    @raw_image.save
    
    redirect_to admin_raw_images_path
    #respond_to do |format|
    #  if @raw_image.save
    #    format.html { redirect_to @raw_image, notice: 'Raw image was successfully created.' }
    #    format.json { render :show, status: :created, location: @raw_image }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @raw_image.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /raw_images/1
  # PATCH/PUT /raw_images/1.json
  def update
    @raw_image.update(raw_image_params)
    redirect_to admin_raw_images_path

  end

  # DELETE /raw_images/1
  # DELETE /raw_images/1.json
  def destroy
    @raw_image.destroy
    redirect_to admin_raw_images_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_image
      @raw_image = RawImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_image_params
      params.require(:raw_image).permit(:identifier, :title, :image)
    end
end
