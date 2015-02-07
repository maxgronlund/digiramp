class User::CmsHorizontalLinksController < ApplicationController
  before_action :set_cms_horizontal_link, only: [:show, :edit, :update, :destroy]
  before_filter :access_user
  
  
  def edit
  end
  
  def update
    cms_section           = @cms_horizontal_link.cms_section
    cms_section.position = params[:cms_horizontal_link][:position]
    cms_section.save!
    params[:cms_horizontal_link].delete :position
    @cms_recording.update(cms_horizontal_link_params) unless params[:cms_horizontal_link] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_horizontal_link.cms_section.cms_page)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_horizontal_link
      @cms_horizontal_link = CmsHorizontalLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_horizontal_link_params
      params.require(:cms_horizontal_link).permit!
    end
end
