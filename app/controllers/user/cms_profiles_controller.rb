class User::CmsProfilesController < ApplicationController
  before_action :set_cms_profile, only: [ :edit, :update]
  before_action :access_user
 

  def edit
  end

  
  def update
    cms_section           = @cms_profile.cms_section
    cms_section.position  = params[:cms_profile][:position]
    cms_section.save!
    params[:cms_profile].delete :position
    @cms_profile.update(cms_profile_params) unless params[:cms_profile] == {}
    redirect_to edit_user_user_cms_page_path(@user, @cms_profile.cms_section.cms_page)

  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_profile
      @cms_profile = CmsProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_profile_params
      params.require(:cms_profile).permit(:user_id)
    end
end
