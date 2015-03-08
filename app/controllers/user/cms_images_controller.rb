class User::CmsImagesController < ApplicationController
  before_action :set_cms_image, only: [:show, :edit, :update, :destroy]
  before_filter :access_user


  def edit
  end


  def update
    ap params
    cms_section           = @cms_image.cms_section
    cms_section.position = params[:cms_image][:position]
    cms_section.save!
    params[:cms_image].delete :position

    @cms_image.update(cms_image_params) unless params[:cms_image] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_image.cms_section.cms_page)

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_image
      @cms_image = CmsImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_image_params
      params.require(:cms_image).permit!
    end
end
