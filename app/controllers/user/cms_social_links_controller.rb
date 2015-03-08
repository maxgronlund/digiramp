class User::CmsSocialLinksController < ApplicationController
  before_action :set_cms_social_link, only: [:show, :edit, :update, :destroy]
  before_filter :access_user
 
  def edit
  end

  
  def update
    
    cms_section           = @cms_social_link.cms_section
    cms_section.position = params[:cms_social_link][:position]
    cms_section.save!
    params[:cms_social_link].delete :position
    @cms_social_link.update(:cms_social_link_params) unless params[:cms_social_link] == {}

    redirect_to edit_user_user_cms_page_path(@user, @cms_vertical_link.cms_section.cms_page)
    
    #respond_to do |format|
    #  if @cms_social_link.update(cms_social_link_params)
    #    format.html { redirect_to @cms_social_link, notice: 'Cms social link was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @cms_social_link }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @cms_social_link.errors, status: :unprocessable_entity }
    #  end
    #end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_social_link
      @cms_social_link = CmsSocialLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_social_link_params
      params.require(:cms_social_link).permit!
    end
end
