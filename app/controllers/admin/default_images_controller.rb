class Admin::DefaultImagesController < ApplicationController
  before_action :set_default_image, only: [:show, :edit, :update, :destroy]
  before_filter :admins_only

  def index
    @default_images = DefaultImage.all
    @user = current_user
    @authorized = true
  end

  def show
    @user = current_user
    @authorized = true
  end

  # GET /default_images/new
  def new
    @default_image = DefaultImage.new

    @user = current_user
    @authorized = true
  end

  # GET /default_images/1/edit
  def edit
    @user = current_user
    @authorized = true
  end

  # POST /default_images
  # POST /default_images.json
  def create
    @default_image = DefaultImage.create(default_image_params)
    redirect_to admin_default_image_path(@default_image)
  end


  def update
    @default_image.update(default_image_params)
    redirect_to admin_default_images_path
  end


  def destroy
    @default_image.destroy
    redirect_to admin_default_images_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_image
      @default_image = DefaultImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_image_params
      params.require(:default_image).permit(:recording_artwork, :user_avatar, :company_logo)
    end
end
