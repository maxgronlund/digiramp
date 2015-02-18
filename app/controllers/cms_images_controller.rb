class CmsImagesController < ApplicationController
  before_action :set_cms_image, only: [:show, :edit, :update, :destroy]

  # GET /cms_images
  # GET /cms_images.json
  def index
    @cms_images = CmsImage.all
  end

  # GET /cms_images/1
  # GET /cms_images/1.json
  def show
  end

  # GET /cms_images/new
  def new
    @cms_image = CmsImage.new
  end

  # GET /cms_images/1/edit
  def edit
  end

  # POST /cms_images
  # POST /cms_images.json
  def create
    @cms_image = CmsImage.new(cms_image_params)

    respond_to do |format|
      if @cms_image.save
        format.html { redirect_to @cms_image, notice: 'Cms image was successfully created.' }
        format.json { render :show, status: :created, location: @cms_image }
      else
        format.html { render :new }
        format.json { render json: @cms_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cms_images/1
  # PATCH/PUT /cms_images/1.json
  def update
    respond_to do |format|
      if @cms_image.update(cms_image_params)
        format.html { redirect_to @cms_image, notice: 'Cms image was successfully updated.' }
        format.json { render :show, status: :ok, location: @cms_image }
      else
        format.html { render :edit }
        format.json { render json: @cms_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms_images/1
  # DELETE /cms_images/1.json
  def destroy
    @cms_image.destroy
    respond_to do |format|
      format.html { redirect_to cms_images_url, notice: 'Cms image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_image
      @cms_image = CmsImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_image_params
      params.require(:cms_image).permit(:image, :url, :clicks)
    end
end
