class User::CmsBannersController < ApplicationController
  before_action :set_cms_banner, only: [:show, :edit, :update, :destroy]
  before_filter :access_user


  def edit
  end


  def update
    cms_section           = @cms_banner.cms_section
    cms_section.position = params[:cms_banner][:position]
    cms_section.save!
    params[:cms_banner].delete :position

    @cms_banner.update(cms_banner_params) unless params[:cms_banner] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_banner.cms_section.cms_page)

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_banner
      @cms_banner = CmsBanner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_banner_params
      params.require(:cms_banner).permit!
    end
end
