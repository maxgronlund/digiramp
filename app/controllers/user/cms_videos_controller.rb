class User::CmsVideosController < ApplicationController
  before_action :set_cms_video, only: [:show, :edit, :update, :destroy]

  before_action :access_user

  def edit
  end
  
  def update
    cms_section           = @cms_video.cms_section
    cms_section.position = params[:cms_video][:position]
    cms_section.save!
    params[:cms_video].delete :position
    @cms_video.update(cms_video_params) unless params[:cms_video] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_video.cms_section.cms_page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_video
      @cms_video = CmsVideo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_video_params
      params.require(:cms_video).permit(:position, :snippet)
    end
end
