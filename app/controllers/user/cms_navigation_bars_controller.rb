class User::CmsNavigationBarsController < ApplicationController
  before_action :set_cms_navigation_bar, only: [:show, :edit, :update, :destroy]
  before_action :access_user
  
  def edit
  end

  
  def update
    cms_section           = @cms_navigation_bar.cms_section
    cms_section.position  = params[:cms_recording][:position]
    cms_section.save!
    #params[:cms_recording].delete :position
    #@cms_navigation_bar.update(cms_recording_params) unless params[:cms_recording] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_navigation_bar.cms_section.cms_page)
  end

 
  def destroy
    @cms_navigation_bar.destroy
    respond_to do |format|
      format.html { redirect_to cms_navigation_bars_url, notice: 'Cms navigation bar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_navigation_bar
      @cms_navigation_bar = CmsNavigationBar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_navigation_bar_params
      params[:cms_navigation_bar]
    end
end
