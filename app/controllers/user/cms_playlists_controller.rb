class User::CmsPlaylistsController < ApplicationController
  before_action :set_cms_playlist, only: [:show, :edit, :update, :destroy]

  before_action :access_user

  def edit
  end
  
  def update

    cms_section           = @cms_playlist.cms_section
    cms_section.position = params[:cms_playlist][:position]
    cms_section.save!
    params[:cms_playlist].delete :position
    @cms_playlist.update(cms_playlist_params) unless params[:cms_playlist] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_playlist.cms_section.cms_page)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_playlist
      @cms_playlist = CmsPlaylist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_playlist_params
      params.require(:cms_playlist).permit(:position, :playlist_id)
    end
end
