class User::CmsPlaylistLinksController < ApplicationController
  before_action :set_cms_playlist_link, only: [:show, :edit, :update, :destroy]
  before_filter :access_user

  def edit
  end
  
  def update
    cms_section           = @cms_playlist_link.cms_section
    cms_section.position = params[:cms_playlist_link][:position]
    cms_section.save!
    params[:cms_playlist_link].delete :position
    @cms_playlist_link.update(cms_playlist_link_params) unless params[:cms_playlist_link] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_playlist_link.cms_section.cms_page)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_playlist_link
      @cms_playlist_link = CmsPlaylistLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_playlist_link_params
      params.require(:cms_playlist_link).permit(:position, :playlist_id)
    end
end
