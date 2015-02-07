class User::CmsVerticalLinksController < ApplicationController
  before_action :set_cms_vertical_link, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  def edit
  end
  
  def update
    cms_section           = @cms_vertical_link.cms_section
    cms_section.position = params[:cms_vertical_link][:position]
    cms_section.save!
    params[:cms_vertical_link].delete :position
    @cms_vertical_link.update(cms_vertical_link_params) unless params[:cms_vertical_link] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_vertical_link.cms_section.cms_page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_vertical_link
      @cms_vertical_link = CmsVerticalLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_vertical_link_params
      params.require(:cms_vertical_link).permit(:recording_id)
    end
end
